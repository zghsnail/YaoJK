//
//  TabbarVC.m
//  ShenDoc
//
//  Created by IOS App on 17/1/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "TabbarVC.h"

#import "HomeViewController.h"
#import "HealthyVC.h"
#import "MakertVC.h"
#import "SocialCircleVC.h"
#import "UserVC.h"

#import "JusaNavigationController.h"

@interface TabbarVC ()


@end

@implementation TabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 1.首页
        HomeViewController *hom = [[HomeViewController alloc] init];
        [self addOneChildController:hom title:@"首页" norImage:@"1-0-1" selectedImage:@"1-0-0"];
        // 1.健康
        HealthyVC *heal = [[HealthyVC alloc] init];
        [self addOneChildController:heal title:@"健康" norImage:@"1-1-1" selectedImage:@"1-1-0"];
        // 1.商城
        MakertVC *makert = [[MakertVC alloc] init];
        [self addOneChildController:makert title:@"商城" norImage:@"1-2-1" selectedImage:@"1-2-0"];
        // 1.圈子
        SocialCircleVC *circle = [[SocialCircleVC alloc] init];
        [self addOneChildController:circle title:@"圈子" norImage:@"1-3-1" selectedImage:@"1-3-0"];
        // 1.我的
        UserVC *main = [[UserVC alloc] init];
        [self addOneChildController:main title:@"我的" norImage:@"1-4-1" selectedImage:@"1-4-0"];
        
    }
    return self;
}

- (void)addOneChildController:(UIViewController *)childVc title:(NSString *)title norImage:(NSString *)norImage selectedImage:(NSString *)selectedImage{
    childVc.title = title;
    
    //保持图片原来的颜色  不加会self.tabBar.tintColor 作为颜色
    childVc.tabBarItem.image = [[UIImage imageNamed:norImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 包装一个导航条
    JusaNavigationController  *nav = [[JusaNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //文字颜色
    self.tabBar.tintColor = FontBlue;

    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump:) name:SBJump object:nil];
    
}

- (void)jump:(NSNotification*)noti{
    NSInteger index = [[[noti object] objectForKey:@"index"] intValue];
    self.selectedIndex = index;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
