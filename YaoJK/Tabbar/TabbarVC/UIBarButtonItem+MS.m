//
//  UIBarButtonItem+MS.m
//  新浪微博(终极)
//
//  Created by msun on 15-6-16.
//  Copyright (c) 2015年 msun. All rights reserved.
//

#import "UIBarButtonItem+MS.h"


@implementation UIBarButtonItem (MS)



- (instancetype)initWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg target:(id)target action:(SEL)action {
    if (self = [super init]) {
        UIButton *btn = [[UIButton alloc] init];
//        [btn setBackgroundImage:[UIImage imageNamed:narImg] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:hightImg] forState:UIControlStateHighlighted];
        [btn setImage:[[UIImage imageNamed:narImg] scaleImageWithWidth:30] forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        //btn.size = btn.currentBackgroundImage.size;
        //btn.imageEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
         btn.size = CGSizeMake(50, 30);
        self = [self initWithCustomView:btn];
        //btn.backgroundColor = NARandomColor;
        
    }
    return self;
}


- (instancetype)initWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg title:(NSString *)title target:(id)target action:(SEL)action {
    if (self = [super init]) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[[UIImage imageNamed:narImg] scaleImageWithWidth:9] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:hightImg] forState:UIControlStateHighlighted];
        [btn setTitle:title forState:UIControlStateNormal];
        //btn.backgroundColor = RandomColor;
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        //btn.size = btn.currentBackgroundImage.size;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        btn.size = CGSizeMake(80, 30);
        self = [self initWithCustomView:btn];
        
    }
    return self;
}

+ (instancetype)barButtonItemWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg title:(NSString *)title  target:(id)target action:(SEL)action {
    return [[self alloc] initWithNormalImg:narImg hightImg:hightImg title:title target:target action:action];
}

+ (instancetype)barButtonItemWithNormalImg:(NSString *)narImg hightImg:(NSString *)hightImg target:(id)target action:(SEL)action {
    return [[self alloc] initWithNormalImg:narImg hightImg:hightImg target:target action:action];
}

@end
