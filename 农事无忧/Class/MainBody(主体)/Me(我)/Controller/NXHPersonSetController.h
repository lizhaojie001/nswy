//
//  NXHPersonSetController.h
//  农事无忧
//
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageBlock)(UIImage *);

@interface NXHPersonSetController : UITableViewController
/**block*/
@property (nonatomic,strong) ImageBlock bolck;
@end
