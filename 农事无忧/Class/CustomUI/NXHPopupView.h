//
//  NXHPopupView.h
//  农事无忧
//
//  Created by Mac on 16/9/20.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXHPopupView : UIView
/**image*/
@property (nonatomic,strong) UIImage * image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *blankView;

@end
