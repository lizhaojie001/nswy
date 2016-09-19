//
//  NXHHeaderBtn.m
//  农事无忧
//
//  Created by Mac on 16/9/19.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHHeaderBtn.h"
@interface NXHHeaderBtn()


@end
@implementation NXHHeaderBtn
 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];

    self.imageView.frame = CGRectMake(0, 5, self.width-20, (self.width-20)*0.95);
    self.imageView.centetX = self.centetX;

//
//    NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5];
//    NSLayoutConstraint * c2 = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20];
//    NSLayoutConstraint * c1 = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0  ];
//
//       NSLayoutConstraint * c3 = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeWidth multiplier:0.95 constant:0];


    self.titleLabel.frame =  CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+2,self.width, 14) ;
    self.titleLabel.centetX = self.centetX;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    //self.titleLabel.backgroundColor = [UIColor redColor];
//    NSLayoutConstraint * c4 = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//NSLayoutConstraint * c6 = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0  ];
//    NSLayoutConstraint * c7 = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-2];
    //[self addConstraints:@[c,c1,c2,c3 ]];

}

@end
