//
//  NXHHeaderVIew.m
//  农事无忧
//
//  Created by Mac on 16/9/13.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHHeaderVIew.h"
@interface NXHHeaderVIew()



@end
@implementation NXHHeaderVIew
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        self.view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.view];
         //[ self addGestureRecognizer];


        return self;
    }
    return nil;
}

//- (void)addGestureRecognizer{
//
//    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self.delegate action:@selector(GroupList)];
//    pan.numberOfTouchesRequired =1;
//    [self.Group addGestureRecognizer:pan];
//    UITapGestureRecognizer * pan1 = [[UITapGestureRecognizer alloc]initWithTarget:self.delegate action:@selector(AddressBookList)];
//    pan1.numberOfTouchesRequired =1;
//    [self.AddressBook addGestureRecognizer:pan1];
//    UITapGestureRecognizer * pan2 = [[UITapGestureRecognizer alloc]initWithTarget:self.delegate action:@selector(emsCnplList)];
//    pan2.numberOfTouchesRequired =1;
//    [self.emsCnpl addGestureRecognizer:pan2];
//    UITapGestureRecognizer * pan3 = [[UITapGestureRecognizer alloc]initWithTarget:self.delegate action:@selector(NoticeList)];
//    pan3.numberOfTouchesRequired =1;
//    [self.Notice addGestureRecognizer:pan3];
//
//}
//#pragma mark -手势方法
//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
