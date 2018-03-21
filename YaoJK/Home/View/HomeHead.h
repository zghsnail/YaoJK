//
//  HomeHead.h
//  YaoJK
//
//  Created by IOS App on 18/1/16.
//  Copyright © 2018年 nova. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeadDelegate<NSObject>

- (void)headCliked:(NSInteger)index;

@end

@interface HomeHead : UIView

@property(nonatomic,weak) id<HomeHeadDelegate> delegate;

@end
