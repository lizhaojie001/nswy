//
//  NXHAboutUsController.m
//  农事无忧
//
//  Created by Mac on 16/9/22.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHAboutUsController.h"

@interface NXHAboutUsController ()
@property (weak, nonatomic) IBOutlet UIView *baseView;

@end

@implementation NXHAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.layer.cornerRadius =3;
    self.automaticallyAdjustsScrollViewInsets = NO;
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

@end
