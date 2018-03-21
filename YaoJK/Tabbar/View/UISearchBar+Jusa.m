//
//  UISearchBar+Jusa.m
//  ShenDoc
//
//  Created by IOS App on 17/1/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "UISearchBar+Jusa.h"

@implementation UISearchBar (Jusa)



- (void)fm_setCancelButtonTitle:(NSString *)title{
    if ([UIDevice currentDevice].systemVersion.doubleValue > 9.0) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}
@end
