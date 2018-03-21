//
//  ProgressHUD.m
//  ShenDoc
//
//  Created by IOS App on 17/1/26.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "ProgressHUD.h"

@implementation ProgressHUD

+ (void)showHudWith:(NSString*)text view:(UIView*)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}

+ (void)showHudMsg:(NSString*)text view:(UIView*)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 30.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3]; 
}

+ (void)hidenHud:(UIView*)view{
    for (UIView* v in view.subviews) {
        if ([v isMemberOfClass:[MBProgressHUD class]]) {
            [v setHidden:YES];
        }
    }
}

@end
