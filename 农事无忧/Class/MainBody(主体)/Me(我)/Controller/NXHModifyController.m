//
//  NXHModifyController.m
//  农事无忧
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHModifyController.h"

@interface NXHModifyController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *phonetextField;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;

@end

@implementation NXHModifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"请输入手机号";
    self.contentView.layer.cornerRadius =5;
    self.NextButton.layer.cornerRadius =5;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)next:(id)sender {
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

@end
