//
//  DLAlertView.h
//  DLAlertView
//
//  Created by David on 16/7/27.
//  Copyright © 2016年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseCallBack)();
typedef void(^ClickCallBack)();

@interface DLAlertView : UIViewController

@property(nonatomic,copy)CloseCallBack closeCallBack;
@property(nonatomic,copy)ClickCallBack clickCallBack;

-(instancetype)initWithWithImage:(UIImage *)image clickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack;

-(instancetype)initWithWithImages:(NSArray *)images clickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack;

-(instancetype)initWithWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor clickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack;
/**
 *  只是用来生成二维码
 *
 *  @param imageName     <#imageName description#>
 *  @param clickCallBack <#clickCallBack description#>
 *  @param closeCallBack <#closeCallBack description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithWithImageName:(NSString *)imageName clickCallBack:(ClickCallBack)clickCallBack andCloseCallBack:(CloseCallBack)closeCallBack;
-(void)show;

@end