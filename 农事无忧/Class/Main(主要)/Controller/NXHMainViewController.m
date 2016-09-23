//
//  NXHMainViewController.m
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHMainViewController.h"
#import "NXHNaviController.h"
#import "NXHHomeViewController.h"
#import "NXHMeViewController.h"
#import "NXHMessageViewController.h"
#import "NXHDiscoverViewController.h"
#import "NXHButton.h"
#import "NXHLoginViewController.h"
#import  <objc/runtime.h>
@interface NXHMainViewController ()<UITabBarControllerDelegate>
/**两个button*/
@property (nonatomic,strong) UIButton * btn1;
/**两个button*/
@property (nonatomic,strong) UIButton * btn2;



@end

@implementation NXHMainViewController
//-(void)switchViewFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    if (fromVC!=nil) {
//        [fromVC willMoveToParentViewController:nil];
//        [fromVC.view removeFromSuperview];
//        [fromVC removeFromParentViewController];
//    }
//    if (toVC!=nil) {
//        [self addChildViewController:toVC];
//        [self.view insertSubview:toVC.view atIndex:0];
//        [toVC didMoveToParentViewController:self];
//    }
//}
//#pragma mark - 魔法指针的使用
//+(void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        SEL originalSelector = @selector(tabBar:didSelectItem:);
//        SEL swizzledSeldctor = @selector(zj_tabBar:didSelectItem:);
//        Method originalMethod =class_getClassMethod(class, originalSelector);
//        Method swizzledMethod = class_getClassMethod(class, swizzledSeldctor);
//        BOOL didAddMethod =class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
//                                           if (didAddMethod) {
//                                               class_replaceMethod(class, swizzledSeldctor, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//                                           }else{
//                                               method_exchangeImplementations(originalMethod, swizzledMethod);
//
//                                           }
//    });
//}
//#pragma mark - Method Swizzling
//- (void)zj_tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    if (LOGEDIN) {
//        [self zj_tabBar:tabBar didSelectItem:item];
//    }else{
//        [self pushLoginView];
//    }
//}
// 
- (BOOL)prefersStatusBarHidden{
    return NO;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate =self;
    [self.tabBar setTintColor:[UIColor lightGrayColor]];
    [self setupAllVc];
    
     }

- (void)setButton{
    CGFloat  W = self.view.width/self.viewControllers.count;
    CGFloat H = self.tabBar.height;


        for (int i = 0; i <2; i ++) {
            if (i==0) {
                _btn1= [[UIButton alloc]
                                     initWithFrame:CGRectMake((i+1)*W, 0, W, H)];
                [_btn1 setBackgroundColor:[UIColor clearColor]];
          
                [_btn1 addTarget:self action:@selector(pushLoginView) forControlEvents:UIControlEventTouchUpInside];
                [self.tabBar addSubview:_btn1];
            }else
            {
                _btn2= [[UIButton alloc]
                        initWithFrame:CGRectMake((i+1)*W, 0, W, H)];
                [_btn2 setBackgroundColor:[UIColor clearColor]];

                [_btn2 addTarget:self action:@selector(pushLoginView) forControlEvents:UIControlEventTouchUpInside];
                [self.tabBar addSubview:_btn2];
            }

        }

}

- (void)setupVc:(UIViewController *)Vc andImage:(UIImage *)image HightlightImage:(UIImage *)hightlightImage andTitle:(NSString *)title{
    
    Vc.title =title;
    Vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    Vc.tabBarItem.selectedImage = [hightlightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    NXHNaviController * navi = [[NXHNaviController alloc]initWithRootViewController:Vc];
    [self addChildViewController:navi];
    
    

}
#pragma mark - 设置自控制器
- (void)setupAllVc{
    NXHHomeViewController * Home = [[NXHHomeViewController alloc]initWithCollectionViewLayout: [[UICollectionViewFlowLayout alloc]init] ];
    
    [self setupVc:Home andImage:[UIImage imageNamed:@"首页"]HightlightImage:[UIImage imageNamed:@"首页1"] andTitle:@"首页"];
    
    NXHMessageViewController * Message = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"NXHMessageViewController"];
    [self setupVc:Message andImage:[UIImage imageNamed:@"消息" ]HightlightImage:[UIImage imageNamed:@"消息1"] andTitle:@"消息"];
    
    
    NXHDiscoverViewController * Discover = [[NXHDiscoverViewController alloc]init];
    [self setupVc:Discover andImage:[UIImage imageNamed:@"发现"] HightlightImage:[UIImage imageNamed:@"发现1"] andTitle:@"发现"];
    
    NXHMeViewController *Me =  [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Me"] ;
    
    [self setupVc:Me  andImage:[UIImage imageNamed: @"我" ]HightlightImage:[UIImage imageNamed:@"我的-(1)2"] andTitle:@"我"];



}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (LOGEDIN) {
        return YES;
    } else
    {if (![viewController isEqual:tabBarController.childViewControllers[0]] ) {
        NXHNaviController *navi = [[NXHNaviController alloc]initWithRootViewController:[[NXHLoginViewController alloc]init]];
        [((UINavigationController*)tabBarController.selectedViewController) presentViewController:navi animated:YES completion:nil];
        return NO;
    }
         return YES;
    }

}
@end
