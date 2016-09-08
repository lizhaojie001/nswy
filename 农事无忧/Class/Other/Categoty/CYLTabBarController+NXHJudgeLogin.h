//
//  CYLTabBarController+NXHJudgeLogin.h
//  农事无忧
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <CYLTabBarController/CYLTabBarController.h>

@interface CYLTabBarController (NXHJudgeLogin)
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController;
@end
