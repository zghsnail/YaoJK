//
//  UIImage+NJ.m
//  8期微博
//
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+NJ.h"

@implementation UIImage (NJ)

+ (instancetype)imageWithName:(NSString *)imageName
{
    // 1.定义返回值
    UIImage *resultImage = nil;
    // 2.判断当前是否是ios7
    if (iOS7) {
        // 注意, 不是所有的图片都有_os7结尾的图片
        NSString *newImageName = [imageName stringByAppendingString:@"_os7"];
        resultImage = [UIImage imageNamed:newImageName];
        // 判断是否有ios7的图片
    }
    
    // 判断是否有ios7的图片
    if (resultImage == nil) {
        resultImage = [UIImage imageNamed:imageName];
    }
    
    // 4.返回结果
    return resultImage;
}

+ (instancetype)resizableImageWithName:(NSString *)imageName
{
    /*
    // 1.创建图片
    UIImage *image = [UIImage imageWithName:imageName];
    // 2.处理图片
    image =  [image stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    // 3.返回图片
    return image;
     */
    
    return [self resizableImageWithName:imageName leftRatio:0.5 topRatio:0.5];
    
    
}


+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio scale:(CGFloat)scale {
        // 1.创建图片
        UIImage *image = [UIImage imageNamed:imageName];
        image = [image scaleImageWithWidth:scale];
        CGSize imageSize = image.size;

        // 2.设置拉伸不变形
        image = [image stretchableImageWithLeftCapWidth:imageSize.width * leftRatio topCapHeight:imageSize.height * topRatio];
        // 3.返回图片
        return image;
}

+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio {
    // 1.创建图片
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize imageSize = image.size;
    // 2.设置拉伸不变形
    image = [image stretchableImageWithLeftCapWidth:imageSize.width * leftRatio topCapHeight:imageSize.height * topRatio];
    // 3.返回图片
    return image;
}

- (UIImage *)scaleImageWithWidth:(CGFloat)width {
    if(self.size.width <width ||width<=0){
        return self;
    }
    
    //缩放比例
    CGFloat scale = self.size.width /width;
    CGFloat height = self.size.height / scale;
    //生成缩小的图像 =>使用Quart2D绘图
    //开始图像上下文,大小是计算出得目标大小
    
    return [self imageScaleToSize:CGSizeMake(width, height)];
}

-(UIImage*) imageScaleToSize:(CGSize)size
{
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    
    //size 为CGSize类型，即你所需要的图片尺寸
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


@end
