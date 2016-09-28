//
//  NXHManualImportQuery.m
//  农事无忧
//
//  Created by Mac on 16/9/28.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHManualImportQuery.h"

@interface NXHManualImportQuery ()
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end

@implementation NXHManualImportQuery
- (IBAction)submit:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.submit.layer.cornerRadius = 3;
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
