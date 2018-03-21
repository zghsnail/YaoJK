//
//  NetTool.h
//  ShenDoc
//
//  Created by 郑国华 on 2017/12/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NAHttpTool.h"
#import "ResponseLoginUser.h"
#import "RequestLoginUser.h"

typedef void(^netEngineSucceed)(id d);

@interface NetTool : NSObject

//登录接口
+ (void)login:(RequestLoginUser *)request success:(void(^)(ResponseLoginUser *user))success failure:(void(^)(NSError *error))failure;

@end
