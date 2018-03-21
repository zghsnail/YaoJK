//
//  BaseModel.h
//  ShenDoc
//
//  Created by IOS App on 17/1/26.
//  Copyright © 2017年 nova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property(nonatomic,copy)NSString *object;
@property(nonatomic,copy)NSString *error_code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,assign) BOOL success;
@property(nonatomic,assign) BOOL num;
@property(nonatomic,copy)NSString *pageCount;
@property(nonatomic,copy)NSString *pageNo;
@property(nonatomic,copy)NSString *pageSize;


/**
 返回的基本数据信息 一般都会包含
 */

@end
