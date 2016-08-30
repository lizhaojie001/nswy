//
//  NXHGudieTool.m
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHGudieTool.h"
#import "NXHSaveTool.h"
#import "NXHMainViewController.h"
#define NXHBVersion @"version"
#import "NXHNewFeatureViewController.h"
@implementation NXHGudieTool
+ (UIViewController *)chooseRootViewController{
    //判断有没有新的版本号
    //获取用户最新的版本号 info.plist
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
 
 
    // app版本
    NSString *curVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        //获取上一次的版本号 =>先保存版本号 -> 偏好设置保存 ->每次进入新特性界面的时候便是有最新版本号,这时候才需要保存
    //获取上一次版本号
     NSString * oldVersion = [NXHSaveTool  objectForKey:NXHBVersion];
    UIViewController *rootVC = nil;
    if ([curVersion isEqualToString:oldVersion]) {
        //没有最新的版本号,进入核心页面
        //创建窗口根控制器
        //UITabbleController控制器的view不是懒加载,在创建控制器的时候就会加载
        rootVC = [[NXHMainViewController alloc]init];
    }else{
        //最新版本号,进入新特性界面,保存当前版本号的最细版本号
        //collectionVc必须初始化的时候设置布局参数
        rootVC = [[NXHNewFeatureViewController alloc] init];
    }
    return rootVC;
}
@end
