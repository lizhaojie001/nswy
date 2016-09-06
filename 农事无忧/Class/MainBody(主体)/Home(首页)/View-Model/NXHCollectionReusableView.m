//
//  NXHCollectionReusableView.m
//  农事无忧
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHCollectionReusableView.h"

@implementation NXHCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.image = [UIImage imageNamed:@"home_top_bg.jpg"];
        [self addSubview:imageView];
        
        
    }
    return self;
    
}
@end
