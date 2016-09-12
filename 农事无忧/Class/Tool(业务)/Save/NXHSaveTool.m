//
//  NXHSaveTool.m
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHSaveTool.h"

@implementation NXHSaveTool

+ (id)objectForKey:(NSString *)defaultName{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}


+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:defaultName forKey:defaultName];
}
/**
 *  存图片到本地
 *
 *  @param suffix  @"xxx.png"
 *  @param image  <#image description#>
 */
+(void)saveImageToDomainsWithDirectorystringByAppendingPathComponent:(NSString *)suffix WithImage:(UIImage *)image{
    //JEPG格式

     NSData *imagedata=UIImageJPEGRepresentation(image,1.0);

    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);

    NSString *documentsDirectory=[paths objectAtIndex:0];

    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:suffix];

    [imagedata writeToFile:savedImagePath atomically:YES];
}
+ (UIImage *)fetchImageWithDirectorystringByAppendingPathComponent:(NSString *)suffix{
NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),suffix];
UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
    return imageView3.image;
}
@end
