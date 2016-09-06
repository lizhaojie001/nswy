//
//  NXHLoginViewController.m
//  农事无忧
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHLoginViewController.h"
#import "SVProgressHUD.h"
//#import "NXHRegister.h"


@interface NXHLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
- (IBAction)registry:(UIButton *)sender;
- (IBAction)findPWD:(UIButton *)sender;
- (IBAction)Login:(UIButton *)sender;




@end

@implementation NXHLoginViewController
-(void)viewWillAppear:(BOOL)animated{
    self.UserName.leftViewMode = UITextFieldViewModeAlways;
    self.UserName.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"太阳副本 6"]];
    self.Password.leftViewMode = UITextFieldViewModeAlways;
    self.Password.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"太阳副本 6"]];
                              
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.UserName.delegate = self;
  //  self.Password.delegate = self;
    // Do any additional setup after loading the view from its nib.
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
//    NXHRegister * r = [[NXHRegister alloc]init];
//    [self presentViewController:r animated:YES completion:nil];
    
}

- (IBAction)findPWD:(UIButton *)sender {
}

- (IBAction)Login:(UIButton *)sender {
    MYLog(@"登录") ;
    [self.Password resignFirstResponder];
    [SVProgressHUD  showWithStatus:@"登陆中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });

}



//#pragma mark - <UITextFiledDalegate>
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return YES;
//    
//}// return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//}// became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//
//    return YES;
//}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;{
//    
//}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//
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
        [self Login:nil];
       
    }
    MYLog(@"%s",__FUNCTION__);
   return  YES;
}// called when 'return' key pressed. return NO to ignore.

@end
