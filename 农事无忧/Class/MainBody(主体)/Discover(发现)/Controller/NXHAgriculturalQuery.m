//
//  NXHAgriculturalQuery.m
//  农事无忧
//
//  Created by Mac on 16/9/28.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHAgriculturalQuery.h"

@interface NXHAgriculturalQuery ()
/**
 *  农药
 */


 /*
 *  肥料
 */
 
/**
 *  种子
 */
 /*
 *  微生物
 */
 
/**
 *  指示
 */
@property (weak, nonatomic) IBOutlet UIImageView *indicator;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *categoryArr;
@end

@implementation NXHAgriculturalQuery
- (IBAction)pesticide:(UIButton*)sender {
    
 
    for (UIButton *btn in self.categoryArr) {
        MYLog(@"btn.selected %@===%d",btn,btn.selected);
            if (btn.tag ==sender.tag    ) {
                [sender setBackgroundColor:ThemeColor];
                continue;
            }
        [btn setBackgroundColor:[UIColor whiteColor]];
               
    }
  
    [UIView animateWithDuration:0.2 animations:^{
        self.indicator.centetX = sender.centetX; 
    }];
   
}
 
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIButton * btn in self.categoryArr) {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.layer.cornerRadius = btn.frame.size.width/2;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
