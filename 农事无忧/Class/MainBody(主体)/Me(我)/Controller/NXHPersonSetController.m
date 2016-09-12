//
//  NXHPersonSetController.m
//  农事无忧
//
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHPersonSetController.h"

@interface NXHPersonSetController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController * _imagePickerController;

}
@property (weak, nonatomic) IBOutlet UIImageView *Avatar;

@end

@implementation NXHPersonSetController
- (void)viewWillAppear:(BOOL)animated{
    if ([NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"]) {
        self.Avatar.image =[NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"];
    }

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
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];

    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;

    //设置摄像头模式（拍照，录制视频）为录像模式
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
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
    if ([NXHSaveTool fetchImageWithDirectorystringByAppendingPathComponent:@"Avatar.png"] == nil) {
          [NXHSaveTool saveImageToDomainsWithDirectorystringByAppendingPathComponent:@"Avatar.png" WithImage:self.Avatar.image];
    }

      [_imagePickerController dismissViewControllerAnimated:YES completion:^{
          self.bolck(self.Avatar.image);
          
    }];
}
- (void)Keep{
     NXHMyLogFunction;
}

 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
 #pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            [self selectImageFromAlbum];
            break;
        case 1:

            break;
        case 2:

            break;

        default:
            break;
    }
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
