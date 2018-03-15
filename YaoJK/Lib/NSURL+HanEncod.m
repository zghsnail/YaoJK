//
//  NSURL+HanEncod.m
//  YaoJK
//
//  Created by IOS App on 18/1/15.
//  Copyright © 2018年 nova. All rights reserved.
//

#import "NSURL+HanEncod.h"

@implementation NSURL (HanEncod)


+(NSURL*)string:(NSString *)url{
    NSString *URL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:URL];
}
@end
