//
//  NXHLogon.m
//  农事无忧
//
//  Created by Mac on 16/9/6.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHLogon.h"

@interface NXHLogon ()
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *Captcha;
- (IBAction)getCaptcha:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)logon:(id)sender;

@end

@implementation NXHLogon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getCaptcha:(id)sender {
   
    
    
}
- (IBAction)logon:(id)sender {
}
@end
