//
//  ProgressHUD.h
//  ShenDoc
//
//  Created by IOS App on 17/1/26.
//  Copyright © 2017年 nova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressHUD : NSObject

+ (void)showHudWith:(NSString*)text view:(UIView*)view;

+ (void)showHudMsg:(NSString*)text view:(UIView*)view;

+ (void)hidenHud:(UIView*)view;
@end
