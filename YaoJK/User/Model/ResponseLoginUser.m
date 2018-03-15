//
//  ResponseLoginUser.m
//  NovaFetalHeart
//
//  Created by duguang on 15/9/23.
//  Copyright (c) 2015年 nuoannuota. All rights reserved.
//

#import "ResponseLoginUser.h"

@implementation ResponseLoginUser
MJCodingImplementation
- (NSString *)userid {
    if (_userid == nil || [_userid isEqualToString:@""]) {
        _userid = @"";
    }
    return _userid;
}


+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"userid" : @"id",
             };
}

- (NSString*)officeId{
    if (_officeId == nil || [_officeId isEqualToString:@""]) {
        _officeId = @"";
    }
    return _officeId;
}
@end


