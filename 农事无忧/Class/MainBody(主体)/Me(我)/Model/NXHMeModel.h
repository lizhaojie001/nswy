//
//  NXHMeModel.h
//  农事无忧
//
//  Created by Mac on 16/9/4.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXHMeModel : NSObject
/**头像*/
@property (nonatomic,strong) UIImageView * Icon;
/**昵称*/
@property (nonatomic,strong) NSString * nickname;
/**账号*/
@property (nonatomic,strong) NSString * ID;
/**QR*/
@property (nonatomic,strong) UIButton * QRCode;

+(instancetype)Model;

@end
