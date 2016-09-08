//
//  NXHFunctionView.m
//  农事无忧
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHFunctionView.h"
@interface NXHFunctionView ()
/**button图片数组*/
@property (nonatomic,strong) NSArray * imageArr;
@property (nonatomic,strong) id SELF;

@end


@implementation NXHFunctionView
 
- (instancetype)initWithSelf:(id)SELF
{
    self = [super init];
    if (self) {
        _SELF =SELF;
//         UIImage  * im =  [UIImage imageNamed:@"zone_avatar_bg.9"] ;
//        UIImageView * imageView = [[UIImageView alloc]initWithImage:im];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        [self addSubview:imageView];
        [self setButton];
        
    }
    
    return self;
}
 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setButton{
   
    for (NSInteger i = 0; i < self.informations.count; i++) {
        UIImage * image = self.informations[i] ;
        UIButton * button = [[UIButton alloc]init ];
        [button setImage:image forState:UIControlStateNormal];
        button.tag =i;
        button.backgroundColor = [UIColor blackColor];
        [button addTarget:self.SELF  action:@selector(pushVc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, button.height, button.width, 20 )];
        label.textAlignment =NSTextAlignmentRight;
        label.text = self.tilte[i];
        [self addSubview:label];
        UIView * view = [[UIView alloc]init];
      //  self addSubview:<#(nonnull UIView *)#>
    }
    
    
    
}
- (void)layoutSubviews{
    CGFloat H = self.height;
    CGFloat W = self.height/self.informations.count;
// 
//    
//            for (int i = 0; i < self.subviews.count/2; i++) {
//                if ([view isKindOfClass:[UIButton class]]) {
//                view.frame = CGRectMake(i*W, 0, W, H-20);
//                }
//            }
//            for (int j = 0;  self.subviews.count/2; j++) {
//            
//                }
//                    view.frame = CGRectMake(i*W, H-20, W, 20);
//                }
//                
//       
    
        
    
}
-(void)pushVc:(NSInteger)tag{
    switch (tag) {
        case 0:
            MYLog(@"0");
            break;
        case 1:
            MYLog(@"1");
            break;
        case 2:
            MYLog(@"2");
            break;
        default:
            break;
    }
    MYLog(@"%s",__func__);
}
- (NSArray *)informations {
    if(_informations == nil) {
        NSMutableArray* arr = [NSMutableArray array];
     
        for (NSInteger i=0; i<4; i++) {
            UIImage * image = [UIImage imageNamed:@"太阳"];
            [arr addObject:image];
            
     
            
        }
        _informations = arr;
          }
    return _informations;
}

- (NSArray <NSString *> *)tilte {
    if(_tilte == nil) {
        _tilte = @[@"群组",@"通讯录",@"公众号",@"通知"];
    }
    return _tilte;
}

 
@end
