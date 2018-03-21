//
//  UIBarButtonItem+MS.h
//  新浪微博(终极)
//
//  Created by msun on 15-6-16.
//  Copyright (c) 2015年 msun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MS)

- (instancetype)initWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg target:(id)target action:(SEL)action;

+ (instancetype)barButtonItemWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg target:(id)target action:(SEL)action;

+ (instancetype)barButtonItemWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg title:(NSString *)title  target:(id)target action:(SEL)action;

- (instancetype)initWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg title:(NSString *)title target:(id)target action:(SEL)action;
@end
