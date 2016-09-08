//
//  NXHFunctionView.h
//  农事无忧
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NXHFunctionView;
@protocol  NXHFunctionViewDelegate <NSObject>
@required
-(id)passValue  ;

@end


@interface NXHFunctionView : UIView
/**按钮图片 */
@property (nonatomic,strong) NSArray  * informations;

/**
 *  文字
 */
/**文字*/
@property (nonatomic,strong) NSArray <NSString *> *tilte;
 
/**delegate*/
@property (nonatomic,weak) id<NXHFunctionViewDelegate>  delegate;

- (instancetype)initWithSelf:(id)SELF;
@end
