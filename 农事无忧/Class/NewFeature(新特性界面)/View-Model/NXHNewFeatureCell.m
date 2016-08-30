//
//  NXHNewFeatureCell.m
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHNewFeatureCell.h"
#import "NXHSaveTool.h"
#import "NXHMainViewController.h"
@interface NXHNewFeatureCell ()
//*展示图片*/
@property (nonatomic,weak) UIImageView * imageView  ;
//*点击按钮*/
@property (nonatomic,weak) UIButton * startButton ;


@end
@implementation NXHNewFeatureCell
- (UIButton *)startButton{
    if (_startButton == nil) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [_startButton sizeToFit];
        [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        _startButton.center =CGPointMake(self.width*0.5, self.height*0.9);
        [self.contentView addSubview:_startButton];
    }
    
    
    return _startButton;
}

- (UIImageView *)imageView {
	if(_imageView == nil) {
		UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView =imageView;
        [self.contentView addSubview:_imageView];
        _imageView.backgroundColor= NXHColor(arc4random()%255, 1, 1);
        
	}
	return _imageView;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

- (void)setUpIndexPath:(NSIndexPath *)indexPath count:(NSInteger)pagesCount
{
    if (indexPath.row == pagesCount - 1) {
        // 最后一行
        // 添加立即体验按钮
        
        self.startButton.hidden = NO;
    }else{
        self.startButton.hidden = YES;
    }
    
}
// 点击立即体验按钮
- (void)start
{
    // 跳转到核心界面,push,modal,切换跟控制器的方法
    NXHKeyWindow.rootViewController = [[NXHMainViewController alloc] init];
    
    CATransition *anim = [CATransition animation];
    anim.duration = 0.5;
    anim.type = @"rippleffect";
    [NXHKeyWindow.layer addAnimation:anim forKey:nil];
}
@end
