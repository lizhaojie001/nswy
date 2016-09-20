//
//  AppDelegate.m
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "AppDelegate.h"
#import "NXHGudieTool.h"




#import "EMSDK.h"
#import "NXHLoginViewController.h"
#import "NXHNaviController.h"
#import "HWPopTool.h"
#import "NXHPopupView.h"

@interface AppDelegate ()<EMClientDelegate>
 
/**弹窗*/
@property (nonatomic,strong)  NXHPopupView * contentView;

@end

@implementation AppDelegate
//初始化设置
+(void)initialize{
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
     
      [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:0.8]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
        [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
        
        [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
        [[UITabBar appearance] setShadowImage:[ [UIImage alloc]init] ]
         ;
          [[UITabBar appearance] setBackgroundImage:  [UIImage imageNamed:@"tapbar_top_line"]] ;
    //  [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
      /// 去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[EMClient sharedClient] addDelegate:self];
    //AppKey:注册的AppKey，详细见下面注释。
//    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"zyl#nswy"];
    options.apnsCertName = @"Test";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
      MYLog(@"%u",[EMClient sharedClient].isLoggedIn);
   // [NSThread sleepForTimeInterval:0.5];
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen  ].bounds];
    self.window =window;
 window.backgroundColor = [UIColor whiteColor];
#warning  暂时 修改
  [NXHGudieTool guideRootViewController:window];
    
   // NXHLoginViewController *login=
//     [[NXHLoginViewController alloc]initWithNibName:nil bundle:nil];
//    NXHNaviController *navi = [[NXHNaviController alloc]initWithRootViewController:login];
//    
//    self.window.rootViewController = navi;
   
    [window makeKeyAndVisible];
  
    return YES;
}
//APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 回调
//异地登录回调
- (void)userAccountDidLoginFromOtherDevice{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账号在其他设备登录,请注意账号安全" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NXHMyLogFunction;
    }];
    [alert addAction:action];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}
//自动登录回调
- (void)didAutoLoginWithError:(EMError *)aError{
    NXHMyLogFunction;
}






-(void)dealloc{
    [[EMClient sharedClient] removeDelegate:self];
}
@end
