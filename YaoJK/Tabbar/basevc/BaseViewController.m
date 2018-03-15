//
//  BaseViewController.m
//  ShenDoc
//
//  Created by IOS App on 17/1/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([NSStringFromClass([self class]) isEqualToString:@"HomeViewController"] || [NSStringFromClass([self class]) isEqualToString:@"HealthyVC"]||[NSStringFromClass([self class]) isEqualToString:@"MakertVC"]||[NSStringFromClass([self class]) isEqualToString:@"SocialCircleVC"] ||[NSStringFromClass([self class]) isEqualToString:@"UserVC"]){
        
    }else{
      self.tabBarController.tabBar.hidden = YES;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([NSStringFromClass([self class]) isEqualToString:@"HomeViewController"] || [NSStringFromClass([self class]) isEqualToString:@"HealthyVC"]||[NSStringFromClass([self class]) isEqualToString:@"MakertVC"]||[NSStringFromClass([self class]) isEqualToString:@"SocialCircleVC"] ||[NSStringFromClass([self class]) isEqualToString:@"UserVC"]){
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    //UI 设计的 返回按钮
    if ([NSStringFromClass([self class]) isEqualToString:@"HomeViewController"] || [NSStringFromClass([self class]) isEqualToString:@"HealthyVC"]||[NSStringFromClass([self class]) isEqualToString:@"MakertVC"]||[NSStringFromClass([self class]) isEqualToString:@"SocialCircleVC"] ||[NSStringFromClass([self class]) isEqualToString:@"UserVC"]){
    }else{
        
    }
    
}

- (void)popAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
