//
//  NXHNoticeCell.h
//  农事无忧
//
//  Created by Mac on 16/9/20.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXHNoticeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarPortraits;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIButton *agree;
@property (weak, nonatomic) IBOutlet UIButton *refuse;

@end
