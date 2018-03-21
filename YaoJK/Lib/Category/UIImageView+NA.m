//
//  UIImageView+NA.m
//  NovaFetalHeart
//
//  Created by duguang on 15/9/29.
//  Copyright (c) 2015年 nuoannuota. All rights reserved.
//

#import "UIImageView+NA.h"

@implementation UIImageView (NA)

- (void)setImageWithUrlStr:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
    
}

- (void)setImageWithUrlStr:(NSString *)url placeHolder:(NSString *)placeHolder {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolder]];
}

@end
