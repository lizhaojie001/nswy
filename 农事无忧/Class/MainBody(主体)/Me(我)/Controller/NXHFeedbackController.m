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
@property (weak, nonatomic) IBOutlet UITextField *ContactTextField;
@property (weak, nonatomic)IBOutlet   NSLayoutConstraint *contactConstraint;
/**联系方式对话框约束临时存储*/
@property (nonatomic,strong) NSLayoutConstraint * constraint1;
/**意见对话框临时存储*/
@property (nonatomic,strong) NSLayoutConstraint * constraint2;

/**<#注释#>*/
@property (nonatomic,assign) CGFloat  spacing;


@end

@implementation NXHFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

 
-(void)keyboardWillShow:(NSNotification*)notification{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] ;
    CGFloat H = _keyboardRect.size.height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            self.constraint2.constant = self.bottom.constant;
            self.constraint1.constant  = self.contactConstraint.constant;
        MYLog(@"%f%f",self.constraint1.constant,self.constraint2.constant);
           
    });
   
//    NSLayoutConstraint * constranit = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:(NSLayoutAttributeBottom) multiplier:1 constant:-H-20];
//    NSLayoutConstraint * ido = [self.bottom copy];
//    self.constraint =constranit;
//    [self.view removeConstraint:self.bottom];
//    [self.view addConstraint:constranit];
//    [self.view updateConstraintsIfNeeded];
    if ([self.textView canBecomeFirstResponder]) {
      [UIView animateWithDuration:2 animations:^{
          self.bottom.constant =H+2;
          [self.view layoutSubviews];
      }  ];
       
    }
   
     
    if ( [self.ContactTextField isEditing]){
        
        [UIView animateWithDuration:0.5 animations:^{
            self.bottom.constant = H+self.ContactTextField.height+10;
            self.contactConstraint.constant = H;
            //+self.ContactTextField.height;
          //  self.spacing = Spacing;
            [self.view layoutSubviews];

        }];
        CGFloat   Spacing = -self.textView.y +self.ContactTextField.y - self.textView.height;
      
             
    }
    //  self.bottom.constant = constant;
  
     
    NXHMyLogFunction;
}
-(void)keyboardWillHide:(NSNotification*)notification{
    NXHMyLogFunction;
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] ;
     
    CGFloat H = _keyboardRect.size.height;
    self.contactConstraint.constant   = self.constraint1.constant;
    self.bottom.constant = self.constraint2.constant;
//    + self.ContactTextField.height+ self.spacing;
     [self.view layoutSubviews];
//    //[self.view removeConstraint:self.constraint];
//    [self.view addConstraint:self.bottom];
//    [self.view updateConstraintsIfNeeded];
//    
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

//- (NSLayoutConstraint *)constraint {
//	if(_constraint == nil) {
//		_constraint = [[NSLayoutConstraint alloc] init];
//	}
//	return _constraint;
//}

 

- (NSLayoutConstraint *)constraint1 {
	if(_constraint1 == nil) {
		_constraint1 = [[NSLayoutConstraint alloc] init];
	}
	return _constraint1;
}

- (NSLayoutConstraint *)constraint2 {
	if(_constraint2 == nil) {
		_constraint2 = [[NSLayoutConstraint alloc] init];
	}
	return _constraint2;
}

@end
