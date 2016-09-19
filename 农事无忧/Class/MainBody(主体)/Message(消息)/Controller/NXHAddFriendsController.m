//
//  NXHAddFriendsController.m
//  农事无忧
//
//  Created by Mac on 16/9/19.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHAddFriendsController.h"

@interface NXHAddFriendsController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate >
@property (weak, nonatomic) IBOutlet UISearchBar *userName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation NXHAddFriendsController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"查找" style:UIBarButtonItemStylePlain target:self action:@selector(find)];
    //[self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)find{
    EMError *error = [[EMClient sharedClient].contactManager addContact:self.userName.text message:@"我想加您为好友"];
    if (!error) {
        NSLog(@"添加成功");
    }
    NXHMyLogFunction;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath


{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    return cell;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    MYLog(@"%@----%@",searchText,searchBar.text);
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
