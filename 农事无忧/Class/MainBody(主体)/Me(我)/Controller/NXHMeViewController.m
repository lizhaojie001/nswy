//
//  NXHMeViewController.m
//  农事无忧
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHMeViewController.h"
#import "NXHMeGroup1Cell.h"
#import "NXHSettingViewController.h"
#import "NXHLoginViewController.h"
#import "NXHNaviController.h"
#import "NXHPersonSetController.h"
#import "DLAlertView.h"
 

@interface NXHMeViewController ()
/**Avatar*/
@property (weak, nonatomic) IBOutlet UIImageView *Avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
 
@property (weak, nonatomic) IBOutlet UIButton *QRbutton;

@end

@implementation NXHMeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


    if ([NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"]&&LOGEDIN) {
        self.loginLabel.hidden = YES;

        self.Avatar.image =[NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"];
        self.nickName.text = [EMClient sharedClient].currentUsername;
        self.ID.text =self.nickName.text;
        self.QRbutton.hidden = NO;

    }
    if (!LOGEDIN) {
#warning 根据登录状态来设置未登录时的图片和ID /昵称

        
                 self.Avatar.image = [UIImage imageNamed:@"icon_user_logo"];
        self.nickName.text = @"";
        self.ID.text = @"";
        self.loginLabel.hidden = NO;
        self.QRbutton.hidden = YES;
        

           }

}
- (IBAction)clickQR:(id)sender {
    DLAlertView * alter = [[DLAlertView alloc]initWithWithImageName:self.nickName.text clickCallBack:nil andCloseCallBack:nil];
    
    [alter show];
}
 
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我";
 
    
}

 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!LOGEDIN) {
        switch (indexPath.row) {
            case 0:{
                UINavigationController * navi =[[NXHNaviController alloc]initWithRootViewController:[NXHLoginViewController sharedInstance] ];

                [self presentViewController:navi animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    }else if (indexPath.section == 2 ) {
        NXHSettingViewController *  VC = [[NXHSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (LOGEDIN) {
        if (indexPath.section == 0) {

            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
 
          NXHPersonSetController   *vc = [storyboard instantiateViewControllerWithIdentifier:@"NXHPersonSetController"];
            __weak __typeof__(self) weakSelf = self;

            vc.bolck = ^(UIImage *  image){
                MYLog(@"11111111%@",image);
                self.Avatar.image =image;
                MYLog(@"--------%@",weakSelf.Avatar.image);
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
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
