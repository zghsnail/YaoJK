//
//  AppDelegate.m
//  YaoJK
//
//  Created by IOS App on 18/1/15.
//  Copyright © 2018年 nova. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Route.h"
#import "TabbarVC.h"
#import "AppDelegate+AliCloudPush.h"
#import <CloudPushSDK/CloudPushSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TabbarVC *tab = [[TabbarVC alloc] init];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
    //阿里推送
    [self registerAPNS:application];
    [self initCloudPush];
    [self registerMessageReceive];
    [CloudPushSDK sendNotificationAck:launchOptions];
    
    //注册组件化
    [self registerRoute];
    //登录
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:Log_In]) {
//        [self performSelector:@selector(showLogin) withObject:nil afterDelay:0.4];
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    Print(@"%@/",url);
    return [[JLRoutes routesForScheme:@"nova"] routeURL:url withParameters:options];
}


- (void)showLogin{
    NSString *url = @"nova://presnet/LoginVC";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}





@end
