//
//  NXHMessageViewController.m
//  农事无忧
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHMessageViewController.h"
#import "UISearchBar+FMAdd.h"


@interface NXHMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
/**UItabbleView*/
@property (nonatomic,strong) UITableView * tableView;
@property (strong, nonatomic)   UISearchBar *customSearchBar;

/**图片*/
@property (nonatomic,strong) NSArray<UIImage *>* imageArr;

@end

@implementation NXHMessageViewController
-(UISearchBar *)customSearchBar{
    if (!_customSearchBar) {
        _customSearchBar = [[UISearchBar alloc]initWithFrame: CGRectMake(0, 64, self.view.width, 40) ];
        [self.view addSubview:_customSearchBar];
    }
    return _customSearchBar;
}
-(void)setSearchBar{
    
    self.customSearchBar.delegate = self;
    self.customSearchBar.placeholder = @"请输入查询信息";
    
    //1. 设置背景颜色
    //设置背景图是为了去掉上下黑线
    self.customSearchBar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    self.customSearchBar.barTintColor = [UIColor whiteColor];
    
    //2. 设置圆角和边框颜色
    UITextField *searchField = [self.customSearchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = ThemeColor.CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
    
    //3. 设置按钮文字和颜色
    [self.customSearchBar fm_setCancelButtonTitle:@"取消"];
    self.customSearchBar.tintColor = [UIColor colorWithRed:86/255.0 green:179/255.0 blue:11/255.0 alpha:1];
    //设置取消按钮字体
    [self.customSearchBar fm_setCancelButtonFont:[UIFont systemFontOfSize:22]];
    //修正光标颜色
    [searchField setTintColor:[UIColor blackColor]];
    
    //4. 设置输入框文字颜色和字体
    [self.customSearchBar fm_setTextColor:[UIColor blackColor]];
    [self.customSearchBar fm_setTextFont:[UIFont systemFontOfSize:14]];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:self.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    if (point.y>(self.customSearchBar.y+self.customSearchBar.height)) {
        [self.view endEditing:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会话";
    
    [self setSearchBar];
    [self setupButton];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}
- (void)setupButton{
    CGFloat W = (self.view.width-40)/4;
    CGFloat H = W;
    for (int i =0; i <4; i++) {
        UIButton  * button = [UIButton buttonWithType:UIButtonTypeCustom];
       // button.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.8];
        button.frame = CGRectMake(i*W+20, self.customSearchBar.y+self.customSearchBar.height, W-10, H-10);
        //[button setTitle:@"点击" forState:UIControlStateNormal];
       // button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:ThemeColor forState:UIControlStateNormal];
        UIImage *image = self.imageArr[i];
                  [button setImage: image forState:UIControlStateNormal];
        button.tag = i;
         button.titleEdgeInsets = UIEdgeInsetsMake(25, 25, 25, 25);
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = ThemeColor.CGColor;
//        button.layer.cornerRadius =(W)/2;
//        [button.layer masksToBounds];
//         button.titleEdgeInsets = UIEdgeInsetsMake(0, -80, -50, 0);
       
        [button addTarget:self action:@selector(click:)  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
- (void)click:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
           
            
            break;
            
        default:
            break;
    }
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = ThemeColor;
     [self.navigationController pushViewController:vc animated:YES];
    MYLog(@"%s",__func__);
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
#pragma mark - (UISearchBar)
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   // [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}
#pragma mark - <UITabbleViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}




- (NSArray<UIImage *> *)imageArr {
	if(_imageArr == nil) {
		_imageArr = @[[UIImage imageNamed:@"comm_group"],[UIImage imageNamed:@"comm_txl"],[UIImage imageNamed:@"comm_open"  ],[UIImage imageNamed:@"comm_notice"] ];
	}
	return _imageArr;
}

@end
