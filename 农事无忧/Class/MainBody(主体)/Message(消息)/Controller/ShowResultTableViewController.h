//
//  ShowResultTableViewController.h
//  Demo_4搜索框
//
//  Created by tareba on 15/11/18.
//  Copyright (c) 2015年 tanada. All rights reserved.
//

#import <UIKit/UIKit.h>
//本控制器被动使用  ，要展示的数据了来源 谁使用由谁提供，于是公开以个数据属性 来存储数据
@interface ShowResultTableViewController : UITableViewController
//数组中所有类型都是Product类型的
@property (nonatomic ,strong)NSArray*resultArray;
@end
