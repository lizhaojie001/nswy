//
//  NXHAboutUsController.m
//  农事无忧
//
//  Created by Mac on 16/9/22.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHAboutUsController.h"
#import "NXHProfileView.h"
#import "CTFrameParserConfig.h"
#import "CTFrameParser.h"
@interface NXHAboutUsController ()
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet NXHProfileView *prefileView;
 
@end

@implementation NXHAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.layer.cornerRadius =3;
     self.automaticallyAdjustsScrollViewInsets = NO;
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = self.prefileView.width;
    NSString * content = @"公司简介:""\n"
    "   北京市农信通科技有限公司(简称农信通科技,"
    "http://www.nxt.com.cn"
    ")是国内最大的涉农信息服务综合运用商,也是市场占有率最高的农业信息化建设全面解决方案提供商。 ";
    NSDictionary * attr  = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:content attributes:attr];
    [attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor redColor] range:[content rangeOfString:@"http://www.nxt.com.cn"]];
    
     //添加下划线
    [attributedString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value: @(kCTUnderlineStyleSingle)  range:[content rangeOfString:@"http://www.nxt.com.cn"]];
    // NSRangeFromString(<#NSString * _Nonnull aString#>)
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString config:config];
    self.prefileView.data = data;
    self.prefileView.height = data.height;
    self.prefileView.backgroundColor = [UIColor yellowColor];
//   NSDictionary *dic = @{
//                          NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:14]
//                          };

   // NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:@"公司简介:                                                                                                   北京市农信通科技有限公司(简称农信通科技,http://www.nxt.com.cn)是国内最大的涉农信息服务综合运用商,也是市场占有率最高的农业信息化建设全面解决方案提供商。  " attributes:dic];


   // [attributeString addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.nxt.com.cn"] range:NSMakeRange(109, 19)];
//    self.CompanyIntroduction.textAlignment=NSTextAlignmentLeft;
//    self.CompanyIntroduction.linkTextAttributes = @{@"http://www.nxt.com.cn":[UIColor redColor]};
//    [self.CompanyIntroduction setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
//    self.CompanyIntroduction.dataDetectorTypes = UIDataDetectorTypeLink ;
//
//       self.CompanyIntroduction.attributedText =attributeString;
    // Do any additional setup after loading the view from its nib.
}
@end
