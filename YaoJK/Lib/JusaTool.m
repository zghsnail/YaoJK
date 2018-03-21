//
//  JusaTool.m
//  ShenDoc
//
//  Created by IOS App on 17/1/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "JusaTool.h"
#import "sys/utsname.h"

@implementation JusaTool

+ (NSString*)registrationId{
    NSString * did = [JusaTool getStrUseKey:DeviceId];
    return did;
}

+ (NSString*)userid{
    if ([self user]) {
        return [self user].userid;
    }
    return @"";
}

+ (BOOL)saveUser:(ResponseLoginUser *)user{
    return [NSKeyedArchiver archiveRootObject:user toFile:NAAccountFilePath];
}

+ (ResponseLoginUser *)user{
    if (![[NSFileManager defaultManager] fileExistsAtPath:NAAccountFilePath]) {
        return nil;
    }
    ResponseLoginUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:NAAccountFilePath];
    
    return user;
}

+ (void)saveStr:(NSString *)str forKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:key];
    [defaults synchronize];
}

+ (NSString*)getStrUseKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [defaults objectForKey:key]?[defaults objectForKey:key]:@"";
    return str;
}

+ (BOOL)isiPhoneX{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"] || [deviceString isEqualToString:@"x86_64"]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (void)logout{
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"peripheral.plist"];
    //如果文件路径存在的话
    BOOL bRet = [defaultManager fileExistsAtPath:filename];
    
    if (bRet) {
        
        NSError *err;
        
        [defaultManager removeItemAtPath:filename error:&err];
    }
    
    if ([defaultManager isDeletableFileAtPath:NAAccountFilePath]) {
        [defaultManager removeItemAtPath:NAAccountFilePath error:nil];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dictionary = [userDefaults dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        if ([key isEqualToString:UserName] || [key isEqualToString:DeviceId]) {
            
        }else{
            [userDefaults removeObjectForKey:key];
        }
        
        [userDefaults synchronize];
    }
    
//    [[EMClient sharedClient].options setIsAutoLogin:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Login_out object:nil];
}

/**
 *  提示用户
 */
+ (void)showNewStatusCount:(NSInteger)newCount target:(UIViewController *)vc{
    // 1.创建控件
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = RGB(0xcc, 0xcc, 0xcc, 0.5);
    label.x = 0;
    label.width = vc.navigationController.view.width;
    label.height = 35;
    label.y = 64 - label.height;
    if ([JusaTool isiPhoneX]) {
        label.y = 44;
    }
    // 在导航条下面插入一个控件
    [vc.navigationController.view insertSubview:label belowSubview:vc.navigationController.navigationBar];
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 2.根据更新到的微博数量设置文本
    if (newCount) {
        // 更新到了数据
        label.text = [NSString stringWithFormat:@"为您加载了%zd条记录", newCount];
    }else{
        // 没有更新到数据
        label.text = @"没有更多记录";
    }
    // 3.执行动画
    label.alpha = 0.0;
    [UIView animateWithDuration:.35 animations:^{
        // 需要执行动画的代码
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        // 执行完动画之后的操作
        [UIView animateWithDuration:.35 delay:.35 options:UIViewAnimationOptionCurveLinear animations:^{
            // 需要执行动画的代码
            label.transform = CGAffineTransformIdentity;
            
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            // 移除控件
            [label removeFromSuperview];
        }];
    }];
}

/**
 *  提示用户
 */
+ (void)showNews:(NSString*)str target:(UIViewController *)vc{
    // 1.创建控件
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = RGB(0xff, 0x99, 0x91, 0.5);
    label.x = 0;
    label.width = vc.navigationController.view.width;
    label.height = 35;
    label.y = 64 - label.height;
    if ([JusaTool isiPhoneX]) {
        label.y = 44;
    }
    // 在导航条下面插入一个控件
    [vc.navigationController.view insertSubview:label belowSubview:vc.navigationController.navigationBar];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = [NSString stringWithFormat:@"%@", str];
    // 3.执行动画
    label.alpha = 0.0;
    [UIView animateWithDuration:.35 animations:^{
        // 需要执行动画的代码
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        // 执行完动画之后的操作
        [UIView animateWithDuration:.35 delay:.35 options:UIViewAnimationOptionCurveLinear animations:^{
            // 需要执行动画的代码
            label.transform = CGAffineTransformIdentity;
            
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            // 移除控件
            [label removeFromSuperview];
        }];
    }];
}

+ (NSString*)getTime:(NSString*)formart{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formart];
    NSDate * senddate=[NSDate date];
    return [dateFormatter stringFromDate:senddate];
}

+ (UIImage*)imageCompression:(UIImage*)img{
    //第一个参数是图片对象，第二个参数是压的系数，其值范围为0~1。
    NSData * imageData = UIImageJPEGRepresentation(img, 0.5);
    return [UIImage imageWithData:imageData];
}


+ (BOOL)judgeIdentityStringValid:(NSString *)identityString{
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2){
        if(![idCardLast isEqualToString:@"X"]|| ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

+ (NSString *) md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
    return  output;
}

+ (BOOL)deptNumInputShouldNumber:(NSString *)str{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}


@end



