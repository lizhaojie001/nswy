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

@interface NXHMainViewController ()


@end

@implementation NXHMainViewController
- (BOOL)prefersStatusBarHidden{
    return NO;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTintColor:[UIColor lightGrayColor]];
    [self setupAllVc];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (!LOGEDIN ) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self setButton];
        });

    }else if (LOGEDIN){
        for (UIView* view in self.tabBar.subviews) {
            if ([view isKindOfClass:[NXHButton class]]) {
                [view removeFromSuperview];
            }
        }
    }
}
- (void)setButton{
    CGFloat  W = self.view.width/self.viewControllers.count;
    CGFloat H = self.tabBar.height;


        for (int i = 0; i < self.viewControllers.count -2; i ++) {
            NXHButton* button = [[NXHButton alloc]
                                 initWithFrame:CGRectMake((i+1)*W, 0, W, H)];
            [button setBackgroundColor:[UIColor clearColor]];
          //  UIImage *image=      self.viewControllers[i+1].tabBarItem.image;
         //   UIImage * selectedImage = self.viewControllers[i+1].tabBarItem.selectedImage;
          //  [button setImage:image forState:UIControlStateNormal];
          //  [button setImage:selectedImage forState:UIControlStateSelected];
           // [button setTitle:self.viewControllers[i].title forState:UIControlStateNormal];
         //   [button setTitleColor:ThemeColor forState:UIControlStateSelected];
          //  button.backgroundColor= [UIColor redColor];
            [button addTarget:self action:@selector(pushLoginView) forControlEvents:UIControlEventTouchUpInside];
            [self.tabBar addSubview:button];
        }

}
-(void)pushLoginView{
    MYLog(@"%s",__func__);
    UINavigationController * navi = [[NXHNaviController alloc]initWithRootViewController:[[NXHLoginViewController alloc]init]];
    [self presentViewController:navi animated:YES completion:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
