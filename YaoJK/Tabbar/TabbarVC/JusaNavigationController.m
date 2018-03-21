//
//  JusaNavigationController.m
//  ShenDoc
//
//  Created by IOS App on 17/1/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "JusaNavigationController.h"

@interface JusaNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation JusaNavigationController
//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

+ (void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    NSString *img = @"0-0-4";
    [bar setBackgroundImage:[UIImage imageNamed:img] forBarMetrics:UIBarMetricsDefault];
    bar.tintColor = [UIColor whiteColor];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[self.navigationController navigationBar] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[self navigationBar] setShadowImage:[[UIImage alloc] init]];
    [[self navigationBar] setTranslucent:NO];
    [self navigationBar].layer.shadowColor = [UIColor blackColor].CGColor;
    [self navigationBar].layer.shadowOffset = CGSizeMake(0.0f , 0.5f);
    [self navigationBar].layer.shadowOpacity = 0.1f;
    [self navigationBar].layer.shadowRadius = 2.0f;
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
