//
//  NSObject+GP.h
//  GoldPackage2
//
//  Created by zzx on 15-9-13.
//  Copyright (c) 2015年 zzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (GP)
-(NSString *) md5HexDigest;
- (CGSize) sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

- (BOOL)contain:(NSString *)target;

@end
