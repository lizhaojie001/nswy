//
//  NXHSaveTool.h
//  农事无忧
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXHSaveTool : NSObject
+ (id)objectForKey:(NSString *)defaultName;

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (void)saveImageToDomainsWithDirectorystringByAppendingPathComponent:(NSString *)suffix WithImage:(UIImage*)image;//后缀
+ (UIImage *)fetchImageWithDirectorystringByAppendingPathComponent:(NSString *)suffix;
@end
