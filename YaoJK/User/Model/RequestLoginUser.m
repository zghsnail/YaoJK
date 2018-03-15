//
//  RequestLoginUser.m
//  NovaFetalHeart
//
//  Created by duguang on 15/9/23.
//  Copyright (c) 2015年 nuoannuota. All rights reserved.
//

#import "RequestLoginUser.h"
#import "JusaTool.h"
@implementation RequestLoginUser


- (NSString*)deviceTyp{
    return @"4";
}

- (NSString*)registrationId{
    return [JusaTool registrationId];
}

@end
