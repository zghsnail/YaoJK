//
//  AppDelegate+Route.m
//  YaoJK
//
//  Created by IOS App on 18/1/15.
//  Copyright © 2018年 nova. All rights reserved.
//

#import "AppDelegate+Route.h"

@implementation AppDelegate (Route)

-(void)registerRoute{
    [self registerPush];
    [self registerPresent];
}

- (void)registerPush{
    [[JLRoutes routesForScheme:@"nova"] addRoute:@"/push/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"controller"]);
        UIViewController *viewc = [[class alloc] init];
        [self paramToVc:viewc param:parameters];
        [[self getCurrentVC].navigationController pushViewController:viewc animated:YES];
        return YES;
    }];
}

- (void)registerPresent{
    [[JLRoutes routesForScheme:@"nova"] addRoute:@"/presnet/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"controller"]);
        UIViewController *viewc = [[class alloc] init];
        [self paramToVc:viewc param:parameters];
        [[self getCurrentVC] presentViewController:viewc animated:YES completion:^{
            
        }];
        return YES;
    }];
}

- (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }else{
        currentVC = rootVC;
    }
    return currentVC;
}

//传参数
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
//    runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}


@end
