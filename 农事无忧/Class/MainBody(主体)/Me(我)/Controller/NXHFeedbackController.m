//
//  NXHFeedbackController.m
//  农事无忧
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHFeedbackController.h"

@interface NXHFeedbackController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (strong, nonatomic)   NSLayoutConstraint *constraint;
@end

@implementation NXHFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    // Do any additional setup after loading the view from its nib.
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

 
-(void)keyboardWillShow:(NSNotification*)notification{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] ;
    CGFloat H = _keyboardRect.size.height;
//    NSLayoutConstraint * constranit = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:(NSLayoutAttributeBottom) multiplier:1 constant:-H-20];
//    NSLayoutConstraint * ido = [self.bottom copy];
//    self.constraint =constranit;
//    [self.view removeConstraint:self.bottom];
//    [self.view addConstraint:constranit];
//    [self.view updateConstraintsIfNeeded];
    self.bottom.constant =H;
    [self.view layoutSubviews];
    NXHMyLogFunction;
}
-(void)keyboardWillHide:(NSNotification*)notification{
    NXHMyLogFunction;
    [self.view removeConstraint:self.constraint];
    [self.view addConstraint:self.bottom];
    [self.view updateConstraintsIfNeeded];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    //[self.view resignFirstResponder];
  //  [self.textView resignFirstResponder];
    NXHMyLogFunction;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSLayoutConstraint *)constraint {
	if(_constraint == nil) {
		_constraint = [[NSLayoutConstraint alloc] init];
	}
	return _constraint;
}

@end
