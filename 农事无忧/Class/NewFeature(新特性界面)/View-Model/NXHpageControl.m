//
//  NXHpageControl.m
//  农事无忧
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHpageControl.h"

@interface NXHpageControl()
/**保存 图片 数组*/
@property (nonatomic,strong) NSMutableArray * picArr  ;



@end
@implementation NXHpageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)curPageControl:(NSInteger)index{
    for (int i = 0; i < self.picArr.count; i ++) {
        if (index == i) {
            ((UIImageView*)self.picArr[i]).highlighted = YES;
            continue;
        }
        ((UIImageView*)self.picArr[i]).highlighted =NO;
    }
    [self layoutSubviews];
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.width;
       
    CGFloat VX = 0;
    CGFloat VY = 0;
    CGFloat VW = w / self.picArr.count;
    CGFloat VH = self.height;

    for (int i = 0; i < self.picArr.count; i ++) {
        UIView * view = self.subviews[i];
        VX = i*VW;
        view.frame = CGRectMake(VX, VY, VW, VH);
        ((UIImageView*)self.picArr[i]).frame= CGRectMake(view.width/2, view.height/2, 20, 20   );
        [self.subviews[i] addSubview:self.picArr[i]];
        
    }
}


- (NSMutableArray *)picArr {
	if(_picArr == nil) {
        _picArr = [NSMutableArray arrayWithCapacity:10];
        UIImageView * imageView = nil;
//        imageView.highlighted = NO;
//
        for(int i = 0 ; i< 4;i++){
          
            imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"indicator_%d_unfocused",i+1]] highlightedImage:[UIImage imageNamed:[NSString stringWithFormat:@"indicator_%d_focused",i+1]]];
            if (i==0) {
                imageView.highlighted =YES;
            }
            
            [_picArr addObject:imageView];
        }
		 
	}
	return _picArr;
}

@end
