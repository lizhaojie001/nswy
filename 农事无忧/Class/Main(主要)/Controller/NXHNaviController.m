//
//  NXHNaviController.m
//  农事无忧
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHNaviController.h"

@interface NXHNaviController ()<UINavigationControllerDelegate>
/**保存临时代理*/
@property (nonatomic,strong) id Delegate;

@end

@implementation NXHNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Delegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate =self;
 
}

+ (void)initialize
{
    //设置全局导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:39/255.0 green:158/255.0 blue:76/255.0 alpha:0.8]];
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[[UIImage imageNamed:@"太阳"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
        [btn setFrame:CGRectMake(0, 0, 40, 40)];
        
        [btn addTarget:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        

        UIBarButtonItem *left = [[UIBarButtonItem  alloc]initWithCustomView:btn];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
           }
    
    [super pushViewController:viewController animated:animated];
    
}
 
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }else{ // 非根控制器
        self.interactivePopGestureRecognizer.delegate = _Delegate;
        
    }
}
@end
