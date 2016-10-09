//
//  NXHProfileView.h
//  农事无忧
//
//  Created by Mac on 16/10/9.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"
@interface NXHProfileView : UIView<UIGestureRecognizerDelegate>
/**数据源*/
@property (nonatomic,strong) CoreTextData * data;

@end
