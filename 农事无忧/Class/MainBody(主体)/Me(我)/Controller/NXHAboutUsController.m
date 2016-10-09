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
- (void)setupUserInterfaceWith:(UIView *)view andString:(NSString *)content andLinkStr:(NSString* )attributedStr{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = view.width;
    NSDictionary * attr  = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:content attributes:attr];
    if (attributedStr.length>0) {
        NSRange range = [content rangeOfString:attributedStr];
        [attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        //添加下划线
        [attributedString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value: @(kCTUnderlineStyleSingle)  range:range];
    }
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString config:config];
    self.prefileView.data = data;
    self.prefileView.height = data.height;
    self.prefileView.backgroundColor = [UIColor yellowColor];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.layer.cornerRadius =3;
     self.automaticallyAdjustsScrollViewInsets = NO;
//1.
    NSString * content = @"公司简介:""\n"
    "   北京市农信通科技有限公司(简称农信通科技,"
    "http://www.nxt.com.cn"
    ")是国内最大的涉农信息服务综合运用商,也是市场占有率最高的农业信息化建设全面解决方案提供商。";
        
    [self setupUserInterfaceWith:self.prefileView andString:content andLinkStr: @"http://www.nxt.com.cn"];

 
}
@end
