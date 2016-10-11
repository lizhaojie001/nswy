//
//  NXHAboutUsCell.m
//  农事无忧
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHAboutUsCell.h"

@implementation NXHAboutUsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
       
   // self.ctView.layer.
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NXHMyLogFunction;
  [super touchesBegan:touches withEvent:event];
    MYLog(@"%@",[super class]);
}
@end
