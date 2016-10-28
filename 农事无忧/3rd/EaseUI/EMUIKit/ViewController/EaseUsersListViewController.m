/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseUsersListViewController.h"

#import "UIViewController+HUD.h"
#import "EaseMessageViewController.h"
#import "ChatViewController.h"
#import "NXHAddFriendsController.h"

@interface EaseUsersListViewController ()

@property (strong, nonatomic) UISearchBar *searchBar;

@end

@implementation EaseUsersListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
  [button addTarget:self action:@selector(addFriends) forControlEvents:UIControlEventTouchUpInside];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(addFriends)];

    [self.view addSubview: self.searchBar];
    self.tableView.frame = CGRectMake(0, self.searchBar.y+self.searchBar.height, self.view.width, self.view.height - self.searchBar.y - self.searchBar.height);
    self.tableView.bounces = NO;
        [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addFriends{
    NXHAddFriendsController * add = [[NXHAddFriendsController alloc]init];
    add.title = @"添加好友";
    [self.navigationController pushViewController:add animated:YES];
}
#pragma mark - setter

- (void)setShowSearchBar:(BOOL)showSearchBar
{
    if (_showSearchBar != showSearchBar) {
        _showSearchBar = showSearchBar;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        if ([_dataSource respondsToSelector:@selector(numberOfRowInUserListViewController:)]) {
            return [_dataSource numberOfRowInUserListViewController:self];
        }
        return 0;
    }
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseUserCell cellIdentifierWithModel:nil];
    EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        return nil;
    } else {
        id<IUserModel> model = nil;
        if ([_dataSource respondsToSelector:@selector(userListViewController:userModelForIndexPath:)]) {
            model = [_dataSource userListViewController:self userModelForIndexPath:indexPath];
        }
        else {
            model = [self.dataArray objectAtIndex:indexPath.row];
        }
        
        if (model) {
            cell.model = model;
        }
        
        return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EaseUserCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<IUserModel> model = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(userListViewController:userModelForIndexPath:)]) {
        model = [_dataSource userListViewController:self userModelForIndexPath:indexPath];
    }
    else {
        model = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    if (model) {
        if (_delegate && [_delegate respondsToSelector:@selector(userListViewController:didSelectUserModel:)]) {
            [_delegate userListViewController:self didSelectUserModel:model];
        } else {
            EaseMessageViewController *viewController = [[EaseMessageViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
      viewController.title = model.buddy;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            NSMutableArray *contactsSource = [NSMutableArray arrayWithArray:buddyList];
            NSMutableArray *tempDataArray = [NSMutableArray array];
            
            // remove the contact that is currently in the black list
            NSArray *blockList = [[EMClient sharedClient].contactManager getBlackList];
            for (NSInteger i = 0; i < buddyList.count; i++) {
                NSString *buddy = [buddyList objectAtIndex:i];
                if (![blockList containsObject:buddy]) {
                    [contactsSource addObject:buddy];
                    
                    id<IUserModel> model = nil;
                    if (weakself.dataSource && [weakself.dataSource respondsToSelector:@selector(userListViewController:modelForBuddy:)]) {
                        model = [weakself.dataSource userListViewController:self modelForBuddy:buddy];
                    }
                    else{
                        model = [[EaseUserModel alloc] initWithBuddy:buddy];
                    }
                    
                    if(model){
                        [tempDataArray addObject:model];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.dataArray removeAllObjects];
                [weakself.dataArray addObjectsFromArray:tempDataArray];
                [weakself.tableView reloadData];
            });
        }
        [weakself tableViewDidFinishTriggerHeader:YES reload:NO];
    });
}

- (void)dealloc
{
}



- (UISearchBar *)searchBar {
	if(_searchBar == nil) {
		_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
	}
	return _searchBar;
}

@end
