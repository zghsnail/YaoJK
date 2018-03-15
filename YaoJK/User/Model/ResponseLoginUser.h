//
//  ResponseLoginUser.h
//  NovaFetalHeart
//
//  Created by duguang on 15/9/23.
//  Copyright (c) 2015年 nuoannuota. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ResponseLoginUser : NSObject

@property(nonatomic,copy)NSString *userid;//返回的是id 实现里面替换成userid
@property(nonatomic,copy)NSString *loginName;
@property(nonatomic,copy)NSString *md5Password;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *officeId;
@property(nonatomic,copy)NSString *officeName;
@property(nonatomic,copy)NSString *registrationId;
@property(nonatomic,copy)NSString *sex;

@property(nonatomic,copy)NSString *addFrom;//": "8",
@property(nonatomic,copy)NSString *address;//": "内蒙古自治区巴彦淖尔市临河区四季花城1-904",
@property(nonatomic,copy)NSString *birthday;//": "1978-04-02 00:00:00.0",
@property(nonatomic,copy)NSString *creater;//": "",
@property(nonatomic,copy)NSString *deviceType;//": "3",
@property(nonatomic,copy)NSString *doctorId;//": "",
@property(nonatomic,copy)NSString *headIcon;//"
@property(nonatomic,copy)NSString *idCard;//": "450681197804024806",
@property(nonatomic,copy)NSString *loginNumber;//": "18967683649",

@property(nonatomic,copy)NSString *mobilePhone;//": "18967683649",

@property(nonatomic,copy)NSString *officeStatus;//": "0",
@property(nonatomic,copy)NSString *password;//": "123456",



@end
