//
//  JusaTool.h
//  ShenDoc
//
//  Created by IOS App on 17/1/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseLoginUser.h"

@interface JusaTool : NSObject


+ (void)saveStr:(NSString *)str forKey:(NSString *)key;

+ (NSString *)getStrUseKey:(NSString *)key;
//是否是iPhone X
+ (BOOL)isiPhoneX;
//推送id
+ (NSString*)registrationId;
//获取用户id
+ (NSString*)userid;
//保存登录对象
+ (BOOL)saveUser:(ResponseLoginUser *)user;
//获取登录对象
+ (ResponseLoginUser *)user;
//手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//提醒
+ (void)showNewStatusCount:(NSInteger)newCount target:(UIViewController *)vc;
+ (void)showNews:(NSString*)str target:(UIViewController *)vc;
//
+ (void)logout;

+ (NSString*)getTime:(NSString*)formart;

+ (UIImage*)imageCompression:(UIImage*)img;
//身份证 验证

+(BOOL)judgeIdentityStringValid:(NSString *)identityString;

+ (NSString *) md5:(NSString *)input;

//判断输入是否为数字
+ (BOOL)deptNumInputShouldNumber:(NSString *)str;

@end
