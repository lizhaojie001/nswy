//
//  NXHMeModel.m
//  农事无忧
//
//  Created by Mac on 16/9/4.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHMeModel.h"

@implementation NXHMeModel
+(instancetype)Model{
    NXHMeModel * model = [[NXHMeModel alloc]init];
    model.Icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"太阳"]];
    model.nickname = @"nickName";
    model.ID =@"id";
    model.QRCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [model.QRCode setImage:[UIImage imageNamed:@"太阳"] forState:UIControlStateNormal];
    
  //  model.QRCode.backgroundColor = [UIColor cyanColor];
    return model;
}
@end
