//
//  NXHContactListCell.h
//  农事无忧
//
//  Created by Mac on 16/9/13.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXHContactListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *lastMessage;

@property (weak, nonatomic) IBOutlet UILabel *lastTime;

@end
