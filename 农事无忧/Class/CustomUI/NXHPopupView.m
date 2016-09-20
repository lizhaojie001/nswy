//
//  NXHPopupView.m
//  农事无忧
//
//  Created by Mac on 16/9/20.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHPopupView.h"

@implementation NXHPopupView
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc]initWithImage:self.image];
        [self addSubview:imageView];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

}
@end
