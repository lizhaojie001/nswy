//
//  NXHLoginViewController.m
//  农事无忧
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHLoginViewController.h"
#import "SVProgressHUD.h"

#import "NXHLogon.h"
#import "NXHMainViewController.h"
#import <RealReachability.h>
#import "AppDelegate.h"

@interface NXHLoginViewController ()<UITextFieldDelegate,UIApplicationDelegate>
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
/**NewWindow*/
@property (nonatomic,strong) UIWindow * NewWindow;
/**previousWindow*/
@property (nonatomic,strong) UIWindow * previousWindow;

- (IBAction)registry:(UIButton *)sender;
- (IBAction)findPWD:(UIButton *)sender;
- (IBAction)Login:(UIButton *)sender;

- (void)zj_setupNewWindow;



@end

@implementation NXHLoginViewController
- (instancetype)init{
    if (self =[super init]) {
        [self zj_setupNewWindow];
    }
    return self;
}
-(void)zj_setupNewWindow{
    
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.windowLevel = UIWindowLevelAlert;
    alertWindow.backgroundColor = [UIColor clearColor];
    alertWindow.rootViewController = self;
    self.NewWindow = alertWindow;

}
- (void)show{
//    __weak typeof(self) weakSelf = self;
    self.previousWindow = [UIApplication sharedApplication].keyWindow;
    [self.NewWindow makeKeyAndVisible];
   
}
static id instance_;

+ (instancetype)sharedInstance
{


        instance_ = [[self alloc] init];

    return instance_;
}

+(void)initialize{
   }


-(void)viewWillAppear:(BOOL)animated{
    
    
    
    
    self.UserName.leftViewMode = UITextFieldViewModeAlways;
    self.UserName.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机(1)"]];
    self.UserName.leftView.contentMode = UIViewContentModeScaleAspectFit;
    self.Password.leftViewMode = UITextFieldViewModeAlways;
    self.Password.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"钥匙"]];
                              
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange:) name:kRealReachabilityChangedNotification object:nil];
    self.UserName.delegate = self;
    self.Password.delegate = self;
//     Do any additional setup after loading the view from its nib.
//    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popVc)];
  //  [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName  , nil] forState:UIControlStateNormal];
    
    
        
     
   
   
    
}

-(void)networkChange:(NSNotification*)notification{
    RealReachability *reachability =(RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
    if (status == RealStatusNotReachable)
    {
        //self.flagLabel.text = @"Network unreachable!";
        [SVProgressHUD showInfoWithStatus:@"网络断开"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
        
    }else{
        [SVProgressHUD showSuccessWithStatus:@"网络恢复"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }

}
- (void)popVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)userName:(UITextField *)sender{
    [sender resignFirstResponder];
    [self.Password becomeFirstResponder];
    MYLog(@"%s",__FUNCTION__);
}

- (IBAction)passWord:(id)sender {
    [sender resignFirstResponder];
     [self performSelector:@selector(Login:) ];
    MYLog(@"%s",__FUNCTION__);
}
/**
 *
 *
 *  @param sender <#sender description#>
 */
- (IBAction)registry:(UIButton *)sender {
    NXHLogon * r = [[NXHLogon alloc]init];
    [self.navigationController pushViewController:r animated:YES];
    
}
#pragma mark - 找回密码
- (IBAction)findPWD:(UIButton *)sender {
}

- (IBAction)Login:(UIButton *)sender {
//    if ([RealReachability sharedInstance].currentReachabilityStatus==RealStatusNotReachable) {
//        [SVProgressHUD showWithStatus:@"网络断开"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//            
//        });
//        return;
//    }
    
    MYLog(@"登录") ;
    [self.Password resignFirstResponder];
    [SVProgressHUD  showWithStatus:@"登陆中"];
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task

            EMError *error = [[EMClient sharedClient] loginWithUsername:@"17181300355" password:@"123456"]; 
            if (!error) {
                MYLog(@"登录成功 设置自动登录");
                //设置自动登录     
                 [[EMClient sharedClient].options setIsAutoLogin:YES];
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    UIWindow * newWindow=  [UIApplication sharedApplication].keyWindow;
                    newWindow.rootViewController = [[NXHMainViewController alloc]init];
                    [newWindow makeKeyAndVisible];

                });
            }else{
                [SVProgressHUD  showWithStatus:[NSString stringWithFormat:@"登陆失败:%@",error ]];
                dispatch_async(dispatch_get_main_queue(), ^{
                   [SVProgressHUD dismiss];
                    
                    
                });
            }


    });
        
    }else{
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         // time-consuming task

         EMError *error = [[EMClient sharedClient] loginWithUsername:@"17181300355" password:@"123456"];
         if (!error) {
             MYLog(@"登录成功");

             dispatch_async(dispatch_get_main_queue(), ^{
                 [SVProgressHUD dismiss];
                 UIWindow * newWindow=  [UIApplication sharedApplication].keyWindow;
                 newWindow.rootViewController = [[NXHMainViewController alloc]init];
                 [newWindow makeKeyAndVisible];
                 return ;

             });
         }else{
             [SVProgressHUD  showWithStatus:[NSString stringWithFormat:@"登陆失败:%@",error ]];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [SVProgressHUD dismiss];
                 return ;
             });
            
         }


     });

 }
     
}



 //限制输入字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    
    
    if ([textField isEqual: self.UserName]) {
  
    NSCharacterSet* cs;
  //invertedSet方法是去反字符，把所有的除了数字字母的字符都找出来
    cs = [[NSCharacterSet  characterSetWithCharactersInString:MustNumber]  invertedSet];
  //把输入框输入的字符string根据cs中字符一个一个去除，cs字符分割成单字符并转化为NSArray，然后componentsJoinedByString是把NSArray的字符通过“”无间隔连接成一个NSString字符赋给filtered，就是只剩数字和字母了
    
    NSString* filtered = [[string  componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (range.location >=11) {
        show(@"长度超出限制");
        return NO;
    }
    
    BOOL canChange = [string   isEqualToString:filtered];
    if (!canChange) {
        show(@"请输入正确的格式");
    }
   // [SVProgressHUD dismissWithDelay:0.5];
    return canChange;
    }
    
    return YES;
}

//限制长度
void show(id formatstring)

{
    
    UIAlertView *Point =  [[UIAlertView alloc] initWithTitle:nil
                           
                                                     message:formatstring
                           
                                                    delegate:nil
                           
                                           cancelButtonTitle:@"OK"
                           
                                           otherButtonTitles:nil]  ;
    
    [Point show];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:self.UserName]) {
        [textField resignFirstResponder];
        [self.Password becomeFirstResponder];

    }else{
        [textField resignFirstResponder];
       // [self Login:nil];
       
    }
    MYLog(@"%s",__FUNCTION__);
   return  YES;
}// called when 'return' key pressed. return NO to ignore.

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
