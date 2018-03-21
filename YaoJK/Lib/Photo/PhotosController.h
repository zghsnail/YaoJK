//
//  PhotosController.h
//  PhotosAsset
//
//  Created by 77 on 2017/7/4.
//  Copyright © 2017年 77. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotosControllerDelegate <NSObject>

@optional

- (void)getImagesArray:(NSMutableArray<UIImage *>*)imagesArray;

@required

@end

@interface PhotosController : BaseViewController

@property (nonatomic, assign) id<PhotosControllerDelegate>  delegate;

@end
