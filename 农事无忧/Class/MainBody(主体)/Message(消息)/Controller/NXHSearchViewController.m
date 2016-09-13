//
//  NXHSearchViewController.m
//  农事无忧
//
//  Created by Mac on 16/9/13.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHSearchViewController.h"

@interface NXHSearchViewController ()

@end

@implementation NXHSearchViewController
-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    NXHMyLogFunction;
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        MYLog(@"%@",self.view.subviews);

    }
    return self;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MYLog(@"%@",self.view.subviews);
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // MYLog(@"%@",self.view.subviews);

    // Do any additional setup after loading the view.
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
