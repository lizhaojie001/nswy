//
//  NXHMeGroup1Cell.h
//  农事无忧
//
//  Created by Mac on 16/9/4.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXHMeGroup1Cell : UITableViewCell

/**头像*/
@property (nonatomic,strong) UIImageView * Icon;
/**昵称*/
@property (nonatomic,strong) UILabel * Nickname;
/**账号*/
@property (nonatomic,strong) UILabel * ID;
/**二维码*/
@property (nonatomic,strong) UIButton * QRCode;


@end
