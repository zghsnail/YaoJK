//
//  BaseTabVC.h
//  ShenDoc
//
//  Created by IOS App on 17/1/26.
//  Copyright © 2017年 nova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabVC : UITableViewController


@property(nonatomic,strong) NSMutableArray *list;
@property(nonatomic,assign) NSInteger   page;
@property(nonatomic,assign) NSInteger   pageSize;
@property(nonatomic,assign) NSInteger   pageCount;

- (void)setPull_RefreshData;
- (void)pullDown;
- (void)loadMore;
@end
