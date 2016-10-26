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
@interface NXHMainViewController ()<UITabBarControllerDelegate,UITabBarDelegate,EMChatManagerDelegate>
/**两个button*/
@property (nonatomic,strong) UIButton * btn1;
/**两个button*/
@property (nonatomic,strong) UIButton * btn2;

/**标记*/
@property (nonatomic,assign) NSInteger indexFlag;


@end

@implementation NXHMainViewController
 
- (BOOL)prefersStatusBarHidden{
    return NO;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMClient sharedClient].chatManager  addDelegate:self delegateQueue:nil];
    
    self.delegate =self;
    MYLog(@"didSelectItem:%@",   self.tabBar.delegate);  
    [self.tabBar setTintColor:[UIColor whiteColor]];
    [self setupAllVc];
    
     }

 

- (void)setupVc:(UIViewController *)Vc andImage:(UIImage *)image HightlightImage:(UIImage *)hightlightImage andTitle:(NSString *)title{
    
    Vc.title =title;
    Vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    Vc.tabBarItem.selectedImage = [hightlightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.badgeValue=@"11";
    NXHNaviController * navi = [[NXHNaviController alloc]initWithRootViewController:Vc];
    [self addChildViewController:navi];
    
    

}
#pragma mark - 设置自控制器
- (void)setupAllVc{
    
    
    
    NXHMessageViewController * Message = [[NXHMessageViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self setupVc:Message andImage:[UIImage imageNamed:@"消息" ]HightlightImage:[UIImage imageNamed:@"消息1"] andTitle:@"消息"];
        
    NXHHomeViewController * Home = [[NXHHomeViewController alloc]initWithCollectionViewLayout: [[UICollectionViewFlowLayout alloc]init] ];
    
    [self setupVc:Home andImage:[UIImage imageNamed:@"首页"]HightlightImage:[UIImage imageNamed:@"首页1"] andTitle:@"首页"];
    
   
    
    
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
//      NXHLoginViewController * login=  [[NXHLoginViewController alloc]init];
//        [login show];
        NXHNaviController *navi = [[NXHNaviController alloc]initWithRootViewController:[[NXHLoginViewController alloc]init]];
        [((UINavigationController*)tabBarController.selectedViewController) presentViewController:navi animated:YES completion:nil];
        
        return NO;
    }
         return YES;
    }

}
#pragma mark -开启tabar动画
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NXHMyLogFunction;
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    
//    if (self.indexFlag != index) {
//        [self animationWithIndex:index];
//    }
//}
// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
   self.indexFlag = index;
    
}
-(void)messagesDidReceive:(NSArray *)aMessages{
    NXHMyLogFunction;
    int j=0;
    for (int i =0; i< [[EMClient sharedClient].chatManager getAllConversations].count; i ++) {
        EMConversation * conversation = [[EMClient sharedClient].chatManager getAllConversations][i];
        j = j + conversation.unreadMessagesCount;
        
    }      
    
    MYLog(@"---------J:%d",j);
    
}
@end
