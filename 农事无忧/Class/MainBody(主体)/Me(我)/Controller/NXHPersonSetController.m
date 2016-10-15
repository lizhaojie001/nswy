//
//  NXHPersonSetController.m
//  农事无忧
//
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHPersonSetController.h"
#import "DLAlertView.h"
#import "ValuePickerView.h"

@interface NXHPersonSetController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    /**
     *  图片选择器
     */
    UIImagePickerController * _imagePickerController;

}
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UILabel *Gender;
/**
 *  账号
 */
@property (weak, nonatomic) IBOutlet UILabel *Account;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *Avatar;
/**
 *  个性签名
 */
@property (weak, nonatomic) IBOutlet UILabel *Signature;
/**性别选择器*/
@property (nonatomic,strong) ValuePickerView * pickView;

@end

@implementation NXHPersonSetController
- (void)viewWillAppear:(BOOL)animated{
    self.Avatar.image =[NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"]?[NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"]: [UIImage imageNamed:@"icon_user_logo"];
    self.Account.text = [EMClient sharedClient].currentUsername;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(Keep)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    _imagePickerController = [[UIImagePickerController alloc]init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;


}
#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;

    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage ];

    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;

    //设置摄像头模式（拍照，录制视频）为录像模式
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    MYLog(@"%@",info);

    self.Avatar.image = info[@"UIImagePickerControllerEditedImage"];
    if ( self.Avatar.image!=nil) {
          [NXHSaveTool saveImageToDomainsWithDirectorystringByAppendingPathComponent:@"Avatar.png" WithImage:self.Avatar.image];
    }

      [_imagePickerController dismissViewControllerAnimated:YES completion:^{
          self.bolck(self.Avatar.image);
          
    }];
}
#warning 上传到服务器----未实现
- (void)Keep{
     NXHMyLogFunction;
}

 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
 #pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
           
            UIAlertController * alter =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self selectImageFromCamera]; 
            }];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self selectImageFromAlbum]; 
            }];
            UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
              
            }];
            [alter addAction:action1];
            [alter addAction:action2];
            [alter addAction:action3];
            [self presentViewController:alter animated:YES completion:nil];
            
            break;
        }
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    [self alterSetTitle:@"设置姓名"];
                }
                    break;
                    case 1:
                    break;
                case 2:
                {
                    DLAlertView * alter = [[DLAlertView alloc]initWithWithImageName: [EMClient sharedClient].currentUsername clickCallBack:nil andCloseCallBack:nil];
                    
                    [alter show];
                    break;
                }
                default:
                    
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self alterSetTitle:@"设置地址"];
                    break;
                    
                default:
                {
                    self.pickView.dataSource = @[@"男",@"女"];
                    self.pickView.pickerTitle = @"性别";
                    __weak typeof(self) WeakSelf = self;
                    self.pickView.valueDidSelect = ^(NSString *value){
                        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
                        WeakSelf.Gender.text =stateArr[0];
                        
                    };
                    [self.pickView show];
                }
                    
         
                    
                    break;
            }
            break;

        default:
            switch (indexPath.row) {
                case 0:
                    [self alterSetTitle:@"设置地区"];
                    break;
                    
                default:
                    [self alterSetTitle:@"个性签名"];
                    break;
            }
            break;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)alterSetTitle:(NSString *)title {
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }  ];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:action1];
    [alter addAction: action2];
    [self presentViewController:alter animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (ValuePickerView *)pickView {
	if(_pickView == nil) {
		_pickView = [[ValuePickerView alloc] init];
        
	}
	return _pickView;
}

@end
