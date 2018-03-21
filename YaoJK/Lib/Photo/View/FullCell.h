//
//  FullCell.h
//  PhotosAsset
//
//  Created by 77 on 2017/7/4.
//  Copyright © 2017年 77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWAsset.h"
#import "AssetsHelper.h"
#import "UIImage+Original.h"

#define screenScale [UIScreen mainScreen].scale
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4

#define imgNormal @"2-3-1"
#define imgSelect @"2-3-0"
#pragma mark 给UIImageView 添加属性（继承的方法）
@interface myImageView :UIImageView;

//给imageView扩充属性
@property (nonatomic,assign) CGSize size;

@end

@interface FullCell : UICollectionViewCell<UIScrollViewDelegate>

@property (nonatomic, retain) myImageView    *FullImageView;// 相册图片的全屏图

@property (nonatomic, retain) UIScrollView    *myScroll; //通过scrollView代理方法来控制图片缩放

@property (nonatomic, assign) CGSize          imgsize;
//@property (nonatomic,retain) PHAsset      *asset;

- (void)makeUI:(PHAsset *)Asset;

@end
