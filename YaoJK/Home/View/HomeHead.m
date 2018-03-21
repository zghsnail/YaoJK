
//
//  HomeHead.m
//  YaoJK
//
//  Created by IOS App on 18/1/16.
//  Copyright © 2018年 nova. All rights reserved.
//

#import "HomeHead.h"

@implementation HomeHead


- (instancetype)init{
    if (self == [super init]) {
        
    }
    return self;
}

- (void)cliked:(UIButton*)bt{
    if ([self.delegate respondsToSelector:@selector(headCliked:)]) {
        [self.delegate headCliked:bt.tag];
    }
}

@end
