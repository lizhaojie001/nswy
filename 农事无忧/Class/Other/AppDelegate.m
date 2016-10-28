//
//  AppDelegate.m
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "AppDelegate.h"
#import "NXHGudieTool.h"
#import "RealReachability.h"



#import "EMSDK.h"
#import "NXHLoginViewController.h"
#import "NXHNaviController.h"
#import "HWPopTool.h"
#import "AFNetworkReachabilityManager.h"
#import "SVProgressHUD.h"
#import "NXHMainViewController.h"
 

@interface AppDelegate ()<EMClientDelegate, EMContactManagerDelegate,EMChatManagerDelegate>
 
 
@end

@implementation AppDelegate
//初始化设置
+(void)initialize{
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];

    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
     
      [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:0.8]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
        
//        [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:1],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
        [[UITabBar appearance] setShadowImage:[ [UIImage alloc]init] ]
         ;
          [[UITabBar appearance] setBackgroundImage:  [UIImage imageNamed:@"tapbar_top_line"]] ;
    //  [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
      /// 去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[EMClient sharedClient] addDelegate:self];
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    /**
     *  注册消息回调
     */
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

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
    
    if([EMClient sharedClient].isAutoLogin){
   self.window.rootViewController = [[NXHMainViewController alloc]init];
    
    }else{
         [NXHGudieTool guideRootViewController:window];
    }
   
    [window makeKeyAndVisible];
  
//网络状态监听
     [GLobalRealReachability startNotifier];
   ;
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
    [self.window.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
}
//自动登录回调
- (void)didAutoLoginWithError:(EMError *)aError{
    NXHMyLogFunction;
}

/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState{
    NXHMyLogFunction;
    MYLog(@"%u",aConnectionState);
}

//网络监听回调
- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
    if (status == RealStatusNotReachable)
    {
        //self.flagLabel.text = @"Network unreachable!";
        [SVProgressHUD showInfoWithStatus:@"网络断开"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
        
    }else{
        [SVProgressHUD showSuccessWithStatus:@"网络恢复"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (status == RealStatusViaWiFi)
    {
       // self.flagLabel.text = @"Network wifi! Free!";
    }
    
    if (status == RealStatusViaWWAN)
    {
        //self.flagLabel.text = @"Network WWAN! In charge!";
    }
    
    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
    
    if (status == RealStatusViaWWAN)
    {
        if (accessType == WWANType2G)
        {
                     }
        else if (accessType == WWANType3G)
        {
            
        }
        else if (accessType == WWANType4G)
        {            }
        else
        {
          //@"Unknown RealReachability WWAN Status, might be iOS6";
        }
    }
    
    
}



-(void)dealloc{
    [[EMClient sharedClient] removeDelegate:self];
    //移除好友回调
    [[EMClient sharedClient].contactManager removeDelegate:self];
   [[NSNotificationCenter defaultCenter] removeObserver:self];
 
 
}

-(void)messagesDidRead:(NSArray *)aMessages{
    NXHMyLogFunction;
}
 
@end
