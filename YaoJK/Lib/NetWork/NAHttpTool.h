//
//  NAHttpTool.h
//  8期微博
//
//  Created by apple on 14-9-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
// 定义了一个名字叫做successBlock没有返回值没有参数的block,
//typedef void (^successBlock)();

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);

@interface NAHttpTool : NSObject
/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param params  求情参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params  success:(successBlock)success failure:(failureBlock)failure;
/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param params  求情参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;

+ (void)postURl:(NSString*)url params:(NSDictionary*)params mark:(NSString*)mark files:(NSArray*)files success:(successBlock)success failure:(failureBlock)failure;

@end
