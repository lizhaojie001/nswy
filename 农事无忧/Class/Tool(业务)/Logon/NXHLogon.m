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

@interface NXHLogon ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *Captcha;
- (IBAction)getCaptcha:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)logon:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *CaptchaBtn;

@property     dispatch_source_t  timer;

@property (nonatomic,copy) NSString * str;
@end

@implementation NXHLogon

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.PhoneNumber.delegate = self;
    // Do any additional setup after loading the view from its nib.
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
    MYLog(@"%@",arc);
    return [arc copy];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)sendHttpRequest{
    NSString *URLString =[NSString stringWithFormat: @"http://http.yunsms.cn/tx/?uid=55088&pwd=fd233a5f6f2d794a90ddd2ba3d538840&mobile=%@&content=您的验证码是：%@&encode=utf8",self.PhoneNumber.text,[self yanzhengma]];
    
  URLString =   [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MYLog(@"URLString:%@",URLString);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
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
    [self sendHttpRequest];
  //  [self openCountdown];
    [self setTimer];
}
- (IBAction)logon:(id)sender {
    if ([self.str  isEqualToString:self.Captcha.text]) {
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
      
    }
}
/*
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
                
//[self.CaptchaBtn setTitleColor:[UIColor blackColor]
//                                       forState:UIControlStateNormal];
                
                self.CaptchaBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            int seconds = time % 60;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.CaptchaBtn setTitle:[NSString stringWithFormat:@"  %.2d ", seconds] forState:UIControlStateNormal];
                
                
//                [self.CaptchaBtn setTitleColor:[UIColor lightGrayColor]
//                    forState:UIControlStateNormal];
                
                self.CaptchaBtn.userInteractionEnabled = NO;
                
            });
            
            time--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}
*/

//方案二 ： 倒计时
- (void) setTimer{
    
    NSTimeInterval timeInterval = 60;
    if (_timer == nil) {
        __block int timeout = timeInterval;
        
        if (timeout!= 0 ) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
            
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //timeover
                    
                    [self cancelTimer];
                    self.CaptchaBtn.enabled = YES;
                    
                  
                }else{
                    
                    int second = timeout;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.CaptchaBtn.titleLabel.text = [NSString stringWithFormat:@"%ds",second];
                        
                        self.CaptchaBtn.enabled = NO;
                        
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void)cancelTimer{
    if (_timer !=nil) {
        dispatch_source_cancel(_timer);
        
        _timer =nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.CaptchaBtn.titleLabel.text = @"0s";
        });
    }
    
    
}
#pragma  mark - <UITextFieldDelegate>
#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
        
    
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
    if (range.location > 12){
        return NO;
    }
        
    return YES;
    
}

@end
