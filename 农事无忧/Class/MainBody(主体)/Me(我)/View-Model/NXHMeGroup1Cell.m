//
//  NXHMeGroup1Cell.m
//  农事无忧
//
//  Created by Mac on 16/9/4.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHMeGroup1Cell.h"
#import "NXHMeModel.h"
@interface NXHMeGroup1Cell()

/**模型*/
@property (nonatomic,strong) NXHMeModel * Model;

@end
@implementation NXHMeGroup1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
                  //使用atoulayout自动布局 代码约束
        //子view的上边缘离父view的上边缘5个像素
        NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:self.Icon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeTop multiplier:1.0 constant:5];
        //子view的左边缘离父view的左边缘5个像素
        NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:self.Icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5];
        //子view的下边缘离父view的下边缘5个像素
        NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:self.Icon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5];
                //把约束添加到父视图上
        //设置宽高约束
        NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:self.Icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.Icon attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
          //设置label
        NSLayoutConstraint * contraint5 =  [NSLayoutConstraint constraintWithItem:self.Nickname  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        NSLayoutConstraint *contraint6 = [NSLayoutConstraint constraintWithItem:self.Nickname attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.Icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:5];
        NSLayoutConstraint *contraint7 = [NSLayoutConstraint constraintWithItem:self.Nickname attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.ID attribute:NSLayoutAttributeTop multiplier:1.0 constant:-5];
        NSLayoutConstraint *contraint8 = [NSLayoutConstraint constraintWithItem:self.ID attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.Icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:5];
        NSLayoutConstraint *contraint9 = [NSLayoutConstraint constraintWithItem:self.ID attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.Icon attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
        //设置QR
        //子view的上边缘离父view的上边缘20个像素
        NSLayoutConstraint *contraint10 = [NSLayoutConstraint constraintWithItem:self.QRCode attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
        //子view的左边缘离父view的左边缘10个像素
        NSLayoutConstraint *contraint11 = [NSLayoutConstraint constraintWithItem:self.QRCode attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        //子view的下边缘离父view的下边缘20个像素
        NSLayoutConstraint *contraint12 = [NSLayoutConstraint constraintWithItem:self.QRCode attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20];
         NSLayoutConstraint *contraint13 = [NSLayoutConstraint constraintWithItem:self.QRCode attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.QRCode attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        //把约束添加到父视图上

        
        
        NSArray *array = [NSArray arrayWithObjects:
                          //头像
            contraint1, contraint2, contraint3,contraint4,
                          //两个label
        contraint5,contraint6,contraint7,contraint8,contraint9,
                          //二维码
                contraint10,contraint11,contraint12,contraint13,  nil  ];
        
        [self addConstraints:array];

    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)Icon{
    if (!_Icon) {
        _Icon = self.Model.Icon;
        [_Icon setTranslatesAutoresizingMaskIntoConstraints:NO];

        [self addSubview:_Icon];
    }
    return _Icon;
}
- (UILabel *)Nickname{
    if (!_Nickname) {
        _Nickname =[[UILabel alloc]init];
        _Nickname.text = self.Model.nickname;
        [_Nickname setTranslatesAutoresizingMaskIntoConstraints:NO];

        [self addSubview:_Nickname];
    }
    return _Nickname;
}
- (UILabel *)ID{
    if (!_ID) {
        _ID = [[UILabel alloc]init];
        _ID.text =self.Model.ID;
        [_ID setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_ID];
    }
    return _ID;
    
}

- (UIButton *)QRCode{
    if (!_QRCode) {
        _QRCode = self.Model.QRCode;
        [_QRCode setTranslatesAutoresizingMaskIntoConstraints:NO];
       
        [self addSubview:_QRCode];
    }
    return _QRCode;
}
-(NXHMeModel *)Model{
    if (!_Model) {
        _Model= [NXHMeModel Model];

    }
    return _Model;
    
}
@end
