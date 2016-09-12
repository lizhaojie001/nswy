 
#import <UIKit/UIKit.h>

@interface UIImage (Image)


// 快速的返回一个最原始的图片
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName;


// 快速拉伸图片
+ (instancetype)imageWithStretchableImageName:(NSString *)imageName;

/**
 *  压缩图片
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
