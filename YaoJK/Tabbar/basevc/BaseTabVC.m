//
//  BaseTabVC.m
//  ShenDoc
//
//  Created by IOS App on 17/1/26.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "BaseTabVC.h"
@interface BaseTabVC ()

@end

@implementation BaseTabVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if ([NSStringFromClass([self class]) isEqualToString:@"HomeViewController"] || [NSStringFromClass([self class]) isEqualToString:@"HealthyVC"]||[NSStringFromClass([self class]) isEqualToString:@"MakertVC"]||[NSStringFromClass([self class]) isEqualToString:@"SocialCircleVC"] ||[NSStringFromClass([self class]) isEqualToString:@"UserVC"]) {
        
    }else{
        self.tabBarController.tabBar.hidden = YES;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([NSStringFromClass([self class]) isEqualToString:@"HomeViewController"] || [NSStringFromClass([self class]) isEqualToString:@"HealthyVC"]||[NSStringFromClass([self class]) isEqualToString:@"MakertVC"]||[NSStringFromClass([self class]) isEqualToString:@"SocialCircleVC"] ||[NSStringFromClass([self class]) isEqualToString:@"UserVC"]) {
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    //UI 设计的 返回按钮
    if ([NSStringFromClass([self class]) isEqualToString:@"HomeViewController"] || [NSStringFromClass([self class]) isEqualToString:@"HealthyVC"]||[NSStringFromClass([self class]) isEqualToString:@"MakertVC"]||[NSStringFromClass([self class]) isEqualToString:@"SocialCircleVC"] ||[NSStringFromClass([self class]) isEqualToString:@"UserVC"]) {
    }else{
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullDown) name:Login_sucess object:nil];
    
    self.page = 1;
    self.pageSize = 10;
    self.pageCount = 0;
    
//    [self setPull_RefreshData];   在类里面调用 以确保是否添加
}

#pragma mark 上啦刷新 下拉更多
- (void)setPull_RefreshData{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
    [header setTitle:@"下拉刷新更多数据" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉刷新更多数据" forState:MJRefreshStateWillRefresh];
    self.tableView.mj_header = header;
    self.tableView.mj_footer =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)pullDown{
    self.page = 1;
    [self.list removeAllObjects];
}

- (void)loadMore{
    
}


- (NSMutableArray*)list{
    if (_list == nil) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        _list = array;
    }
    return _list;
}

- (void)popAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
