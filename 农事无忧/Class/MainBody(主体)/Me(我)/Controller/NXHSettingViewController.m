//
//  NXHSettingViewController.m
//  农事无忧
//
//  Created by Mac on 16/9/4.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHSettingViewController.h"
#import "NXHNaviController.h"
#import "NXHMainViewController.h"
#import "NXHAboutController.h"
#import "NXHModifyController.h"
#import "NXHFeedbackController.h"
#import "SVProgressHUD.h"
#import "NXHLoginViewController.h"
#import "AppDelegate.h"


 

@interface NXHSettingViewController ()<UIAlertViewDelegate>
/**设置数据项*/
@property (nonatomic,strong) NSArray * settingArr;
/**保存plist数据*/

@property (nonatomic,strong) NSDictionary * dataDict;

@end

@implementation NXHSettingViewController
- (BOOL)hidesBottomBarWhenPushed{
    return YES;
}
 
static NSString * const Cell = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    MYLog(@"%@",self.settingArr);
    // Uncomment the following line to preserve selection between presentations.
  
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return section == 0?5:2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
 //   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    UIImage *image = nil;
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    image = [UIImage imageNamed:@"img_change_password"];
                    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    cell.textLabel.text = @"修改密码";
                
                    break;
                case 1:
                    image = [UIImage imageNamed:@"img_change_tel"];
                    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    cell.textLabel.text =@"修改手机号";
                    break;
                    case 2:
                    image = [UIImage imageNamed:@"img_clear_record" ];
                    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    cell.textLabel.text = @"清空记录";
                    break;
                    case 3:
                    image = [UIImage imageNamed:@"img_update"];
                    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    cell.textLabel.text = @"更新版本";
                    break;
                case 4:
                    image = [UIImage imageNamed:@"img_feed_back"];
                    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    cell.textLabel.text =@"意见反馈";
                    break;
                default:
                    break;
            }
        }
            break;

        default:

            switch (indexPath.row) {
                case 0:
                    image = [UIImage imageNamed:@"img_about_us"];
                    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    cell.textLabel.text = @"关于我们";
                    break;
                    case 1:
                    image = [UIImage imageNamed:@"img_logout"];
                    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    cell.textLabel.text = @"退出";
                    break;
                default:
                    break;
            }
            break;
    }


    MYLog(@"%ld %ld",(long)indexPath.row ,(long)indexPath.section);
    return cell;
}

#pragma mark <UITableViewData>
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 1:
                case 0:{
                    NXHModifyController* modify = [[NXHModifyController alloc]initWithNibName:nil bundle:nil];
                    [self.navigationController pushViewController:modify animated:YES];
                    break;
                }
                    case 2:
                {
                    [SVProgressHUD showWithStatus:@"清理中..."];
                  //  [SVProgressHUD dismissWithDelay:1];
                  
                       
                       // [SVProgressHUD dismiss];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD showSuccessWithStatus:@"清理完成"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [SVProgressHUD dismiss];
                            });

                        });
                                        

                   
                                       break;
                     }
                case 4:{
                    NXHFeedbackController*feedback = [[NXHFeedbackController alloc]init];
                    [self.navigationController pushViewController:feedback animated:YES];
                    break;
                }
                default:
                {
                    
                    [SVProgressHUD showWithStatus:@"正在检测是否有新版本"];
                 
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"软件更新" message:@"发现程序有更新的版本?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        alert.tag = 20;
                        [alert show];
                        });
                   
                    
                }
                    
                    break;
            }
            break;

        default:
            switch (indexPath.row) {
                case 0:
                {

                    NXHAboutController* about = [[NXHAboutController alloc]init];

                    [self.navigationController pushViewController:about animated:YES];
                }
                    break;
                    
                default:{
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出账户吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag =10;
                    [alert show];
                    break;
                }
                }
            break;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==10) {
        switch (buttonIndex) {
            case 0:
               //不做操作
                NXHMyLogFunction;
                break;
            default:{
                //退出登录
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                EMError *error = [[EMClient sharedClient] logout:NO];
                if (!error) {
                    [SVProgressHUD showWithStatus:@"正在退出..."];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD showSuccessWithStatus:@"退出成功"];
                        MYLog(@"是否在线%i",[EMClient sharedClient].isLoggedIn);
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            AppDelegate *app = [UIApplication sharedApplication].delegate; // 获取当前app单例  
                            
                            UIViewController *vc = app.window.rootViewController;  
                            [vc removeFromParentViewController];
                            vc.view = nil;
                            app.window.rootViewController = [[NXHLoginViewController alloc]init];  
                        });
                    });
                  
                }
            });
            
                   
                  
                    
               
            }
                break;
        }

    }
    
    
    
   }
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
