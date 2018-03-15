//
//  RequestLoginUser.h
//  NovaFetalHeart
//
//  Created by duguang on 15/9/23.
//  Copyright (c) 2015年 nuoannuota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestLoginUser : NSObject

//String	是	用户名
@property(nonatomic,copy)NSString * loginNumber;
//String	是	密码                  //password
@property(nonatomic,copy)NSString * password;

/*
 *  登录设备类型   2 ios
 */
@property (nonatomic ,copy)NSString *deviceTyp;

/*
 *  极光推送的接收设备的Reg.ID
 */
@property (nonatomic ,copy)NSString *registrationId;
@end
