//
//  AppDelegate+AliCloudPush.m
//  YaoJK
//
//  Created by IOS App on 18/1/15.
//  Copyright © 2018年 nova. All rights reserved.
//

#import "AppDelegate+AliCloudPush.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (AliCloudPush)


- (void)initCloudPush{
    [CloudPushSDK asyncInit:AliKey appSecret:AliScreat callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            Print(@"Push SDK : deviceId: %@", [CloudPushSDK getDeviceId]);
            [JusaTool saveStr:[CloudPushSDK getDeviceId] forKey:DeviceId];
        } else {
            Print(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

/**
 *  注册苹果推送，获取deviceToken用于推送
 */
- (void)registerAPNS:(UIApplication *)application {
    // iOS 8 Notifications
    [application registerUserNotificationSettings:
     [UIUserNotificationSettings settingsForTypes:
      (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                       categories:nil]];
    [application registerForRemoteNotifications];
}

/*
 *  苹果推送注册成功回调，将苹果返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            Print(@"Register deviceToken success.");
        } else {
            Print(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}

/*
 *  苹果推送注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    Print(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}
/**
 *   注册推送消息到来监听
 */
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
/**
 *   处理到来推送消息
 */
- (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    Print(@"Receive message title: %@, content: %@.", title, body);
}
/*
 *  App处于启动状态时，通知打开回调
 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    Print(@"Receive one notification.%@",userInfo);
    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    NSString *title = [content valueForKey:@"title"];
    NSString *body = [content valueForKey:@"body"];
    // iOS badge 清0
    application.applicationIconBadgeNumber = 0;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:body preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {    }];
    
    [alertController addAction:action];
    [alertController addAction:action1];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    [CloudPushSDK sendNotificationAck:userInfo];
}
@end
