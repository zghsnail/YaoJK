//
//  UIImage+NJ.h
//  8期微博
//
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NJ)
/**
 *  根据传入的图片名称, 自动返回当前系统对应的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 对应系统版本的图片
 */
+ (instancetype)imageWithName:(NSString *)imageName;

/**
 *  根据图片名称创建一张拉伸不变形的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 拉伸不变形的图片
 */
+ (instancetype)resizableImageWithName:(NSString *)imageName;

/**
 *  根据图片名称创建一张拉伸不变形的图片
 *
 *  @param imageName  图片名称
 *  @param leftRatio  左边不拉伸比例
 *  @param topRatio 顶部不拉伸比例
 *
 *  @return 拉伸不变形的图片
 */



+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio;

-(UIImage*) imageScaleToSize:(CGSize)size;
- (UIImage *)scaleImageWithWidth:(CGFloat)width;

+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio scale:(CGFloat)scale;

@end
