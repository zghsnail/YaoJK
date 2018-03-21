//
//  UIImageView+NA.h
//  NovaFetalHeart
//
//  Created by duguang on 15/9/29.
//  Copyright (c) 2015年 nuoannuota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (NA)

- (void)setImageWithUrlStr:(NSString *)url;

- (void)setImageWithUrlStr:(NSString *)url placeHolder:(NSString *)placeHolder;

@end
