//
//  AppDelegate+AliCloudPush.h
//  YaoJK
//
//  Created by IOS App on 18/1/15.
//  Copyright © 2018年 nova. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AliCloudPush)


- (void)initCloudPush;


- (void)registerAPNS:(UIApplication *)application;

- (void)registerMessageReceive;


@end
