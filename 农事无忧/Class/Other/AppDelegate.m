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

@interface AppDelegate ()
 

@end

@implementation AppDelegate

+(void)initialize{
    
    
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
    //AppKey:注册的AppKey，详细见下面注释。
//    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"zyl#nswy"];
    options.apnsCertName = @"Test";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
     [[EMClient sharedClient] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
