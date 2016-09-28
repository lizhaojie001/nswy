//
//  NXHTraceController.m
//  农事无忧
//
//  Created by Mac on 16/9/27.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHTraceController.h"
#import "QRScanViewController.h"
#import "NXHManualImportQuery.h"
#import "NXHAgriculturalQuery.h"

@interface NXHTraceController ()

@end

@implementation NXHTraceController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"产品追溯";
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
        {
            QRScanViewController * QR = FromSB(@"Storyboard", @"QR");  
            [self.navigationController pushViewController:QR animated:YES];
        
            break;
        }
        case 1  :
        {
            NXHManualImportQuery *query = [[NXHManualImportQuery alloc]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:query animated:YES];
            
            break;
        }
        default:
        {
            NXHAgriculturalQuery * query = [[NXHAgriculturalQuery alloc]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:query animated:YES];
        }
            break;
    }
}
 @end
