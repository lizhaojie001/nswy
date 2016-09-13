//
//  NXHMessageViewController.m
//  农事无忧
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHMessageViewController.h"
#import "UISearchBar+FMAdd.h"
#import "NXHButton.h"
#import "EaseUsersListViewController.h"
#import "ShowResultTableViewController.h"
#import "NXHSearchViewController.h"
#import "NXHContactListCell.h"
#import "NXHHeaderVIew.h"





@interface NXHMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,UISearchBarDelegate ,UIGestureRecognizerDelegate  >

@property (strong, nonatomic) IBOutlet UITableView *tableView1;

@property (weak, nonatomic) IBOutlet UITableView *tableView2;


/**全部临时会话列表*/
@property (nonatomic,strong) NSArray  *  allConversationList;
/**记录搜索控制器*/
@property (nonatomic,strong) UISearchController * searchController;
/**展示搜索结果控制器*/
@property (nonatomic,strong)  ShowResultTableViewController* showResultVC;


 

@property (strong, nonatomic)   UISearchBar *customSearchBar;

/**图片*/
@property (nonatomic,strong) NSArray<UIImage *>* imageArr;

/**文字*/
@property (nonatomic,strong) NSArray <NSString*> * strArr;

/**头视图*/
@property (nonatomic,strong) NXHHeaderVIew * sectionHeaderView;

@end

@implementation NXHMessageViewController

#pragma mark -UIGestureRecognizerDelegate  添加手势

//- (void)addGestureRecognizer{
//
//    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GroupList)];
//    pan.numberOfTouchesRequired =1;
//    [self.Group addGestureRecognizer:pan];
//    UITapGestureRecognizer * pan1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddressBookList)];
//     pan1.numberOfTouchesRequired =1;
//    [self.AddressBook addGestureRecognizer:pan1];
//    UITapGestureRecognizer * pan2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emsCnplList)];
//     pan2.numberOfTouchesRequired =1;
//    [self.emsCnpl addGestureRecognizer:pan2];
//    UITapGestureRecognizer * pan3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(NoticeList)];
//     pan3.numberOfTouchesRequired =1;
//    [self.Notice addGestureRecognizer:pan3];
//
//}
#pragma mark -手势方法
#pragma mark - NXHHeaderVIewDelegate
-(void)GroupList{
    NXHMyLogFunction;
}
- (void)AddressBookList{
    EaseUsersListViewController* list = [[EaseUsersListViewController alloc]init];
    list.title = @"好友列表";
    [self.navigationController pushViewController:list animated:YES];

    NXHMyLogFunction;
}
- (void)emsCnplList{
    NXHMyLogFunction;
}
- (void)NoticeList{
    NXHMyLogFunction;
}
#pragma mark - 设置searcherVC
- (void)setUpSearchVC{
    //创建用于展示搜索结果的表Vc的实例
    self.showResultVC=[[ShowResultTableViewController alloc]init];

    //创建搜索控制器的实例
    self.searchController=[[UISearchController alloc]initWithSearchResultsController:self.showResultVC];
    //配置搜索条   设置搜索条的尺寸为自适应
    [self.searchController.searchBar sizeToFit];

    //设置搜索条中的分段类别
    self.searchController.searchBar.scopeButtonTitles=@[@"设备",@"软件",@"其他"];


    //为当前表透视图添加searchBar
    self.tableView1.tableHeaderView=self.searchController.searchBar;

    //设置搜索控制器的结果更新代理对象
    self.searchController.searchResultsUpdater=self;

    //允许当前界面切换栈 数据的上下文对象
    self.definesPresentationContext=YES;

    //为了点击seacherBar上的类别按钮时也能立即响应，需要设置seacherBar的代理
    self.searchController.searchBar.delegate=self;


}

#pragma mark - 搜索框代理方法UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(NXHSearchViewController *)searchController{
    NXHMyLogFunction;
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    [self updateSearchResultsForSearchController:self.searchController];
}
#pragma mark - 自定义searchBar
/*
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
*/

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpSearchVC];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会话";
    self.tableView2.delegate = self;
    self.tableView1.delegate = self;
    self.tableView1.bounces = NO;
    self.tableView2.frame = CGRectMake(0, 189, self.view.width, 125);
    //[self addGestureRecognizer];
     

}


#pragma mark -设置按钮
/*
- (void)setupButton{
    CGFloat W = (self.view.width)/4;
    
    for (int i =0; i <4; i++) {
        NXHButton  * button = [NXHButton buttonWithType:UIButtonTypeCustom];
       // button.backgroundColor = 
        button.frame = CGRectMake(i*W, self.customSearchBar.y+self.customSearchBar.height, W, 48);
        [button setTitle:self.strArr[i] forState:UIControlStateNormal];
       // button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:ThemeColor forState:UIControlStateNormal];
        UIImage *image = self.imageArr[i];
                  [button setImage: image forState:UIControlStateNormal];
        button.tag = i;
    
       
        [button addTarget:self action:@selector(click:)  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
   
    }
    
}
- (void)click:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
            break;
        case 1:{
            EaseUsersListViewController* list = [[EaseUsersListViewController alloc]init];
            list.title = @"好友列表";
            [self.navigationController pushViewController:list animated:YES];
            break;
        }
            
        default:
            break;
    }
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = ThemeColor;
//     [self.navigationController pushViewController:vc animated:YES];
    MYLog(@"%s",__func__);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableView1]) {
        return 1;
    }
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        return cell;

    }
   NXHContactListCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"ContactListCell"];
     

    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    NXHMyLogFunction;
//    if ([tableView isEqual:self.tableView1]) {
//        return 81;
//    }
//    return 45;
//}
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NXHMyLogFunction;
//    return self.sectionHeaderView;
//}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableView2]) {
        return @"会话";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.tableView1]) {
        return 81;
    }
    return 60;
}

#pragma mark 懒加载
//- (UITableView *)tableView{
//    if (!_tableView) {
//        CGFloat Y =self.customSearchBar.y+self.customSearchBar.height+48;
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,Y , ScreenSize.size.width, ScreenSize.size.height-Y) style:UITableViewStylePlain];
//        [self.view addSubview:_tableView];
//        _tableView.backgroundColor =RandomColor;
//        _tableView.bounces=NO;
//    }
//    return _tableView;
//}




- (NSArray<UIImage *> *)imageArr {
	if(_imageArr == nil) {
		_imageArr = @[[UIImage imageNamed:@"comm_group"],[UIImage imageNamed:@"comm_txl"],[UIImage imageNamed:@"comm_open"  ],[UIImage imageNamed:@"comm_notice"] ];
	}
	return _imageArr;
}

- (NSArray <NSString*> *)strArr {
	if(_strArr == nil) {
        _strArr = @[@"群组",@"通讯录",@"公众号",@"通知"];
    }
	return _strArr;
}



 

@end
