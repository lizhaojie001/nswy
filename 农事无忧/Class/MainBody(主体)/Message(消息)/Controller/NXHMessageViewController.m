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
 
#import "ShowResultTableViewController.h"
#import "NXHSearchViewController.h"
#import "NXHContactListCell.h"
#import "NXHHeaderBtn.h"
#import "ChatViewController.h"
#import "EaseConversationCell.h"





@interface NXHMessageViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UISearchBarDelegate,EMChatManagerDelegate   >

@property (strong, nonatomic)  UIView *baseView;
 
 
@property (weak, nonatomic) IBOutlet UIView *searchView;


/**全部临时会话列表*/
@property (nonatomic,strong) NSArray  *  allConversationList;
/**记录搜索控制器*/
@property (nonatomic,strong) UISearchController * searchController;
/**展示搜索结果控制器*/
@property (nonatomic,strong)  ShowResultTableViewController* showResultVC;

/**暂存接受信息*/
@property (nonatomic,strong) NSString  * str;
@property (nonnull,nonatomic,strong) UIView * badge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOftableView;
 
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfBaseView;
 

@property (strong, nonatomic)   UISearchBar *customSearchBar;

/**图片*/
@property (nonatomic,strong) NSArray<UIImage *>* imageArr;

/**文字*/
@property (nonatomic,strong) NSArray <NSString*> * strArr;
 

 

#pragma mark 功能按钮
 @end

@implementation NXHMessageViewController

- (void)addviews{
    CGFloat W = self.view.width/4.0;
    CGFloat H = W;
    UIView * v = [[UIView alloc]init];

    for (int i =0; i < 4; i++) {

       
         
        
        NXHHeaderBtn * btn = [[NXHHeaderBtn alloc]initWithFrame:CGRectMake(i*W, 0, H, H)];
    //    [btn setBackgroundImage: [UIImage imageNamed:@"bg_ffffff"] forState:UIControlStateNormal];
        
       [btn setBackgroundColor:RandomColor];
        [btn setImage:self.imageArr[i] forState:UIControlStateNormal];
        [btn setTitle:self.strArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        
        btn.tag = i;
        v.tag = i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:btn];

//
//        if (i==3) {
//            _badge = [[UIView alloc]init];
//            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:_badge attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeTop multiplier:1.0 constant:5];
//            NSLayoutConstraint * c1 = [NSLayoutConstraint constraintWithItem:_badge attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5];
//            NSLayoutConstraint * c2 = [NSLayoutConstraint constraintWithItem:_badge attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_badge attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
//            _badge.backgroundColor = [UIColor redColor];
//            _badge.hidden = YES;
//            [v addConstraints:@[c,c1,c2]];
//            [v addSubview:_badge];
//        }

       
       
    }
    self.baseView =v;
}

 

 #pragma mark - 设置searcherVC
- (void)setUpSearchVC{
    //创建用于展示搜索结果的表Vc的实例
    self.showResultVC=[[ShowResultTableViewController alloc]init];
   
    //创建搜索控制器的实例
    self.searchController=[[UISearchController alloc]initWithSearchResultsController:self.showResultVC];
    self.searchController.view.backgroundColor = [UIColor lightGrayColor];
        //配置搜索条   设置搜索条的尺寸为自适应
    [self.searchController.searchBar sizeToFit];

    //设置搜索条中的分段类别
   // self.searchController.searchBar.scopeButtonTitles=@[@"设备",@"软件",@"其他"];
    //[self.searchController.searchBar setTintColor:ThemeColor];
     //为当前表透视图添加searchBar
     [self.tableView.tableHeaderView addSubview: self.searchController.searchBar];


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
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [self setUpBadge];
      
  
   }
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //取消监听
    [[EMClient sharedClient].chatManager removeDelegate:self];

   }
#pragma mark -- 接收消息回调
- (void)didReceiveMessages:(NSArray *)aMessages{
     [self.tableView reloadData];
    [self setUpBadge];
   }
#pragma mark -- 已读消息回调
- (void)didReceiveHasReadAcks:(NSArray *)aMessages{
    [self setUpBadge];
    
}
- (void)setUpBadge{
    int j=0;
    for (int i =0; i< _allConversationList.count; i ++) {
        EMConversation * conversation = _allConversationList[i];
        j = j + conversation.unreadMessagesCount;
        
    }      
    j!=0?[self stopRefresh]: [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
    self.tabBarItem.badgeValue =j==0?nil: [NSString stringWithFormat:@"%d",j];
}
- (void)stopRefresh{
    [self.tableView.mj_header endRefreshing];
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationItem.title = @"会话";
    [self addviews];
    [self.tableView registerClass:[EaseConversationCell class] forCellReuseIdentifier:@"Cell"] ;
       self.tableView.tableHeaderView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
     [self setUpSearchVC];
        MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.allConversationList =nil;
        [weakSelf.tableView reloadData];
        [weakSelf setUpBadge];
    }]; 
    //[self.tableView registerNib:[UINib nibWithNibName:@"headerView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerView"];
    [self setUpBadge];

   }

 
- (void)click:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
            break;
        case 1:{
            EaseUsersListViewController* list = [[EaseUsersListViewController alloc]initWithStyle:UITableViewStylePlain];
            list.showSearchBar = YES;
           list.title = @"好友列表";
            [self.navigationController pushViewController:list animated:YES];
            break;
        }
        case 2:
            break;
        default:
            
            break;
    }

    MYLog(@"%s",__func__);
}



#pragma mark - (UISearchBar)
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    [self.view endEditing:YES];
}
#pragma mark - <UITabbleViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return section==0?1: self.allConversationList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        self.baseView.frame = cell.contentView.bounds;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
      cell.backgroundColor=ThemeColor;
        [cell.contentView addSubview:self.baseView];
        return cell;
    }else{
        EaseConversationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        EMConversation *conversation  = self.allConversationList[indexPath.row];
        MYLog(@"--------%d",conversation.latestMessage.body.type );
        switch (conversation.latestMessage.body.type ) {
            case EMMessageBodyTypeText:{
                // 收到的文字消息
                  EMMessageBody *msgBody =conversation.lastReceivedMessage.body;
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
              cell.detailLabel.text =  textBody.text;
         
                break;
            }
            default:
                break;
        }   
        cell.timeLabel.text = [NSString stringWithFormat:@"%lld",  conversation.latestMessage.localTime];
        cell.titleLabel.text =  conversation.latestMessage.direction?conversation.latestMessage.from :conversation.latestMessage.to;
       // cell.avatarView.imageView= []
    //    cell.lastMessage.text = 
           return cell;
    }
    
 
 
}
 
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section==0? nil:@"会话";
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return self.view.width/4.0;
            break;    
        default:
            return 60;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section==0?0:10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =  [[UIView alloc]init ];//]WithFrame:CGRectMake(0, 0, 100, 100)];
       switch (section ) {
        case 0:
            return view;
            break;
            
        default:
            return  nil;

            break;
    }
  }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section) {
        EaseConversationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        ChatViewController *viewController = [[ChatViewController alloc] initWithConversationChatter:cell.titleLabel.text conversationType:EMConversationTypeChat];
        viewController.title = cell.titleLabel.text;
        [self.navigationController pushViewController:viewController animated:YES];
        

    }
             }

#pragma mark 懒加载




- (NSArray<UIImage *> *)imageArr {
	if(_imageArr == nil) {
		_imageArr = @[[UIImage imageNamed:@"comm_group"],
                      [UIImage imageNamed:@"comm_txl"],
                      [UIImage imageNamed:@"comm_open"  ],
                      [UIImage imageNamed:@"comm_notice"]
                      ];
	}
	return _imageArr;
}

- (NSArray <NSString*> *)strArr {
	if(_strArr == nil) {
        _strArr = @[@"群组",@"通讯录",@"公众号",@"通知"];
    }
	return _strArr;
}



 

- (NSArray *)allConversationList {
	if(_allConversationList == nil) {


        _allConversationList = [[EMClient sharedClient].chatManager getAllConversations];
        
    }
        	return _allConversationList;
    
}


#pragma mark -监听回调

/**
 * 当监听到object的keyPath属性发生了改变
 */


- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage{
   }

-(void)dealloc{
    NXHMyLogFunction;
}
    
@end
