//
//  NSObject+GP.m
//  GoldPackage2
//
//  Created by zzx on 15-9-13.
//  Copyright (c) 2015年 zzx. All rights reserved.
//

#import "NSString+GP.h"


@implementation NSString (GP)

-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (CGSize) sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    NSDictionary *attr = @{NSFontAttributeName:font};
    CGSize strSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
    
//    
//        CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(240.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
//    
    
    return strSize;
}

- (BOOL)contain:(NSString *)target {
    
    NSRange range = [self rangeOfString:target];
    
    return range.location != NSNotFound;
}

@end
