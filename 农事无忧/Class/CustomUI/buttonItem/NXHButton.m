//
//  NXHButton.m
//  农事无忧
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHButton.h"

@implementation NXHButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat H = 30;
    CGFloat W = self.frame.size.width  ;
    CGFloat X = (W -36)/2;
    //CGPoint Center = self.center;
    [self.imageView sizeToFit];
    self.imageView.frame =CGRectMake(X, 0, H, H-2);
    //self.titleLabel.frame = CGRectMake(0, 0, W, 12);
    self.titleLabel.width = W;
    self.titleLabel.frame= CGRectMake(0, 36, self.width, 12);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.numberOfLines = 1;
}
@end
