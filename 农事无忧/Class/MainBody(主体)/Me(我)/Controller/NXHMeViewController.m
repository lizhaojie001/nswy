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

@interface NXHMeViewController ()
/**Avatar*/
@property (weak, nonatomic) IBOutlet UIImageView *Avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *ID;
 

@end

@implementation NXHMeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"]&&LOGEDIN) {
        self.Avatar.image =[NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"];
    }
    if (LOGEDIN) {
#warning 根据登录状态来设置未登录时的图片和ID /昵称
    }

}
 
//- (instancetype)initWithStyle:(UITableViewStyle)style{
//    if (self = [super initWithStyle:style] ) {
//        self = [[NXHMeViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    }
//    return  self;
//     }
//static NSString *const Cell = @"Cell";
//static NSString * const cell1 = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我";
   // [self.tableView registerClass:[NXHMeGroup1Cell class] forCellReuseIdentifier:Cell];
  //  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell1];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}


//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return  3 ;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
////#warning Incomplete implementation, return the number of rows
//
//        switch (section) {
//            case 0:
//                return 1;
//                
//            case 1:
//                return 2;
//            default:
//                return 1;
//        }
//
//
//
//   }

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    switch (indexPath.section) {
        case 0:{
        NXHMeGroup1Cell *cell1 = [tableView dequeueReusableCellWithIdentifier:Cell forIndexPath:indexPath];
            cell1.Icon = self.avator;
            return cell1;
        }
         case 1:
            if (indexPath.row ==0) {
                cell.imageView.image = [UIImage imageNamed:@"img_trends"];
                cell.textLabel.text = @"动态";
            }else{
                cell.imageView.image = [UIImage imageNamed:@"img_collect"];
                cell.textLabel.text = @"收藏";
            }
            break;
        default:
            cell.imageView.image = [UIImage imageNamed: @"img_set" ];
            cell.textLabel.text = @"设置";
            break;
    }
        return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 74;
            
            
        default:
            return 40;
    }
}
 */
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
