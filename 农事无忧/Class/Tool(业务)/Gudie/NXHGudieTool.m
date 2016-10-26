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
 
#import "NXHNFViewController.h"
#import "CYLTabBarController.h"
#import "NXHMessageViewController.h"
#import "NXHHomeViewController.h"
#import "NXHMeViewController.h"
#import "NXHDiscoverViewController.h"
#import "NXHNaviController.h"
#import "NXHLoginViewController.h"

#define NXHUserDefaults [NSUserDefaults standardUserDefaults]

@interface NXHGudieTool()

@end
@implementation NXHGudieTool
+ (void )guideRootViewController:(UIWindow*)window{
    //判断有没有新的版本号
    //获取之前版本号
    NSString *oldVersion = [NXHUserDefaults objectForKey:NXHBVersion];

    //获取当前版本
    NSString *verKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[verKey];
 //获取上一次的版本号 =>先保存版本号 -> 偏好设置保存 ->每次进入新特性界面的时候便是有最新版本号,这时候才需要保存
  
  
    if ([currentVersion isEqualToString:oldVersion]) {
        //没有最新的版本号,进入核心页面
        //创建窗口根控制器
        //UITabbleController控制器的view不是懒加载,在创建控制器的时候就会加载
        
        window.rootViewController = [[NXHLoginViewController alloc]init];
        
    }else{
        //最新版本号,进入新特性界面,保存当前版本号的最细版本号
        [NXHUserDefaults setObject:currentVersion forKey:NXHBVersion];
        [NXHUserDefaults synchronize];
        

        // 必须初始化的时候设置布局参数
        window.rootViewController = [[NXHNFViewController alloc] init];
        
    }
    }


+(UIViewController*)setupViewControllers {
    NXHHomeViewController*Home =  [[NXHHomeViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    UIViewController *Navi1 = [[NXHNaviController alloc]
                               initWithRootViewController:Home];
  
    NXHDiscoverViewController *Discover = [[NXHDiscoverViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UIViewController *Navi3 = [[NXHNaviController alloc]
                               initWithRootViewController:Discover];
    NXHMessageViewController *Message = [[NXHMessageViewController alloc] init];
    UIViewController *Navi2 = [[NXHNaviController alloc]
                               initWithRootViewController:Message];
    
    NXHMeViewController *Me =  [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Me"] ;
    UIViewController *Navi4 = [[NXHNaviController alloc]
                               initWithRootViewController:Me];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           Navi1,
                                           Navi2,
                                           Navi3,
                                           Navi4
                                           ]];
    return tabBarController;
}

 /*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
+ (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"main_bottom_home",
                            CYLTabBarItemSelectedImage : @"main_bottom_home_selected",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"main_bottom_comm",
                            CYLTabBarItemSelectedImage : @"main_bottom_comm_selected",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"main_bottom_more",
                            CYLTabBarItemSelectedImage : @"main_bottom_more_selected",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我",
                            CYLTabBarItemImage : @"main_bottom_personcenter",
                            CYLTabBarItemSelectedImage : @"main_bottom_personcenter_selected",
                            };
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2 ,dict3,dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}
@end
