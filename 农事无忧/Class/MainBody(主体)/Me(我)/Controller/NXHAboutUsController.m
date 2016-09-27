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
@property (weak, nonatomic) IBOutlet UITextView *CompanyIntroduction;

@end

@implementation NXHAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.layer.cornerRadius =3;
     self.automaticallyAdjustsScrollViewInsets = NO;
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:14]
                          };

    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:@"公司简介:                                                                                                   北京市农信通科技有限公司(简称农信通科技,http://www.nxt.com.cn)是国内最大的涉农信息服务综合运用商,也是市场占有率最高的农业信息化建设全面解决方案提供商。  " attributes:dic];


   // [attributeString addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.nxt.com.cn"] range:NSMakeRange(109, 19)];
    self.CompanyIntroduction.textAlignment=NSTextAlignmentLeft;
    self.CompanyIntroduction.linkTextAttributes = @{@"http://www.nxt.com.cn":[UIColor redColor]};
    [self.CompanyIntroduction setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
    self.CompanyIntroduction.dataDetectorTypes = UIDataDetectorTypeLink ;

       self.CompanyIntroduction.attributedText =attributeString;
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
