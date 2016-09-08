//
//  CYLTabBarController+NXHJudgeLogin.m
//  农事无忧
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "CYLTabBarController+NXHJudgeLogin.h"
#import "EMClient.h"
#import "NXHLoginViewController.h"
#import "AppDelegate.h"

@implementation CYLTabBarController (NXHJudgeLogin)
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([EMClient sharedClient].isLoggedIn) {
        NSUInteger selectedIndex = tabBarController.selectedIndex;
        UIButton *plusButton = CYLExternPlusButton;
        if (CYLPlusChildViewController) {
            if ((selectedIndex == CYLPlusButtonIndex) && (viewController != CYLPlusChildViewController)) {
                plusButton.selected = NO;
            }
        }
        UIApplication * application = [UIApplication sharedApplication];
        AppDelegate *App2 = application.delegate;      NXHLoginViewController * vc =  [[NXHLoginViewController alloc]init];
        App2.window.rootViewController = vc;
        return YES;
    }
    
    
    return NO;

}
@end
