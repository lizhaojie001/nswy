//
//  NXHLogon.m
//  农事无忧
//
//  Created by Mac on 16/9/6.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHLogon.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
 
#import "UIColor+NXHColor.h"
#import "NXHEreg.h"
#import "EMClient.h"
@interface NXHLogon ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *Captcha;
 
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)logon:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *CaptchaBtn;
@property (weak, nonatomic) IBOutlet UIButton *logon;

//@property     dispatch_source_t  timer;

@property (nonatomic,copy) NSString * str;
@end

@implementation NXHLogon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.CaptchaBtn setTitle:@"免费获取验证码" forState:UIControlStateNormal];
    
    self.PhoneNumber.delegate = self;
    self.pwd.delegate = self;
}


- (NSString *)yanzhengma{
    NSMutableString *str =  [NSMutableString string];
    NSString * arc;
    for (int i=0; i <6; i++) {
       
   arc= [str stringByAppendingFormat:@"%u",arc4random()%10 ];
        MYLog(@"%@",arc);
        str = [NSMutableString stringWithFormat:@"%@",arc];
    }
    self.str = arc;
    return arc;
}
- (void)sendHttpRequest{
    NSString *URLString =[NSString stringWithFormat: @"http://http.yunsms.cn/tx/?uid=55088&pwd=fd233a5f6f2d794a90ddd2ba3d538840&mobile=%@&content=您的验证码是：%@&encode=utf8",self.PhoneNumber.text,[self yanzhengma]];
    
  URLString =   [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MYLog(@"URLString:%@",URLString);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            MYLog   (@"Error: %@", error);
        } else {
            MYLog(@"%@ %@", response, responseObject);
        }
        
    }];
    [dataTask resume];
}
- (IBAction)getCaptcha:(id)sender {
    if ((self.CaptchaBtn.enabled =(self.PhoneNumber.text.length==11))) {
        [self sendHttpRequest];
        [self openCountdown];
    }
  
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 注册
- (IBAction)logon:(id)sender {
    if ([self.str  isEqualToString:self.Captcha.text]) {
        if ((self.pwd.text.length>=6)&&(self.pwd.text.length<=16)) {
    EMError *error = [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"w%@",self.PhoneNumber.text] password:self.pwd.text];
            if (error==nil)
            {
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }else{
        
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%u",error.code]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
        }
    }
}
//倒计时验证码
-(void)openCountdown{
    
    
    __block NSInteger time = 59;
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.CaptchaBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.CaptchaBtn setTitleColor:[UIColor colorFromHexCode:@"FB8557"] forState:UIControlStateNormal];
                
                
                self.CaptchaBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            int seconds = time % 60;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.CaptchaBtn setTitle:[NSString stringWithFormat:@"重新发送%.2d ", seconds] forState:UIControlStateNormal];
                
[self.CaptchaBtn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
    self.CaptchaBtn.userInteractionEnabled = NO;
            });
            time--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}

/*
//方案二 ： 倒计时
- (void) setTimer{
    
    NSTimeInterval timeInterval = 59;
    if (_timer == nil) {
        __block int timeout = timeInterval;
        
        if (timeout!= 0 ) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
            
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //timeover
                    
                    [self cancelTimer];
                  //  self.CaptchaBtn.enabled = YES;
                    
                  
                }else{
                    
                    int second = timeout;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.CaptchaBtn setTitle:[NSString stringWithFormat:@"（%d）",second] forState:UIControlStateNormal];
                        
                        self.CaptchaBtn.enabled = NO;
                        
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}
*/
//- (void)cancelTimer{
//    if (_timer !=nil) {
//        dispatch_source_cancel(_timer);
//        
//        _timer =nil;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.CaptchaBtn.titleLabel.text = @"0s";
//        });
//    }
//    
//    
//}
#pragma  mark - <UITextFieldDelegate>
#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([textField isEqual:self.PhoneNumber]) {
        if (range.location == 0){
            NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1"] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if (!basicTest){
                //[self showMyMessage:@"只能输入数字"];
                return NO;
            }
        }
        else if (range.location == 1){
            NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"^[3,4,5,7,8]$"] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if (!basicTest){
                //[self showMyMessage:@"只能输入数字"];
                return NO;
            }
        }
        if (range.location >= 11){
            return NO;
        }
    }else if([textField isEqual:self.pwd]){
        NSCharacterSet* cs;
        
        //invertedSet方法是去反字符，把所有的除了数字字母的字符都找出来
        
        cs = [[NSCharacterSet  characterSetWithCharactersInString:PWDMustCarter]  invertedSet];
        
        
        
        //把输入框输入的字符string根据cs中字符一个一个去除，cs字符分割成单字符并转化为NSArray，然后componentsJoinedByString是把NSArray的字符通过“”无间隔连接成一个NSString字符赋给filtered，就是只剩数字和字母了
        
        NSString* filtered = [[string  componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL canChange = [string   isEqualToString:filtered];
        
        //6-16位密码
        if (range.location>=6&&range.location<=16) {
            self.logon.enabled = YES;
        }
       
       
        return canChange;
    }
    
    return YES;
   }

@end
