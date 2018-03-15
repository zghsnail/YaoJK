//
//  LoginVC.m
//  ShenDoc
//
//  Created by IOS App on 17/1/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "LoginVC.h"
#import "TabbarVC.h"
#import "BaseViewController.h"
@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField    *nameFiled;
@property (nonatomic,strong) UITextField    *pwdFuled;
@property (nonatomic,strong) UIView     *bgView;

@end

@implementation LoginVC

- (UIView*)bgView{
    if (_bgView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
            view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _bgView = view;
    }
    return _bgView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:[self bgView]];
    
    [self initView];
}

- (void)initView{
    
    UITapGestureRecognizer *r5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    r5.numberOfTapsRequired = 1;
     [self.bgView addGestureRecognizer:r5];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 70) / 2, 105, 70, 70)];
    icon.image = [UIImage imageNamed:@"0-0-2"];
    [_bgView addSubview:icon];
    
    _nameFiled = [[UITextField alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(icon.frame) + 75, ScreenWidth - 120, 50)];
    _nameFiled.placeholder = @"用户名";
    _nameFiled.font = [UIFont systemFontOfSize:20];
    _nameFiled.delegate = self;
    _nameFiled.returnKeyType = UIReturnKeyNext;
    _nameFiled.textAlignment = NSTextAlignmentLeft;
    [_bgView addSubview:_nameFiled];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, _nameFiled.height-0.5, _nameFiled.width, 0.5)];
    line1.backgroundColor = RGB(0xcc, 0xcc, 0xcc, 1);
    [_nameFiled addSubview:line1];
    
    _pwdFuled = [[UITextField alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(_nameFiled.frame) + 30, _nameFiled.width, 50)];
    _pwdFuled.placeholder = @"密码";
    _pwdFuled.returnKeyType = UIReturnKeyGo;
    _pwdFuled.font = [UIFont systemFontOfSize:20];
    _pwdFuled.secureTextEntry = YES;
    _pwdFuled.delegate = self;
    _pwdFuled.textAlignment = NSTextAlignmentLeft;
    [_bgView addSubview:_pwdFuled];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _pwdFuled.height-0.5, _pwdFuled.width, 0.5)];
    line2.backgroundColor = RGB(0xcc, 0xcc, 0xcc, 1);
    [_pwdFuled addSubview:line2];
    
    UIButton *subbutton = [[UIButton alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(_pwdFuled.frame) + 45, _pwdFuled.width, 50)];
    [subbutton setTitle:@"登 录" forState:UIControlStateNormal];
    [subbutton setTitleColor:RGB(0xff, 0x7b, 0x6d, 1) forState:UIControlStateNormal];
    subbutton.layer.borderColor = RGB(0xff, 0x7b, 0x6d, 1).CGColor;
    [subbutton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    subbutton.layer.borderWidth = 1;
    subbutton.layer.cornerRadius = 25;
    [_bgView addSubview:subbutton];
    
    _nameFiled.text = @"18967683649";
    _pwdFuled.text = @"123456";
}

- (void)login{
    [_nameFiled resignFirstResponder];
    [_pwdFuled resignFirstResponder];
    if (_nameFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    if (_nameFiled.text.length <= 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    [self loginWithName:_nameFiled.text Pwd:_pwdFuled.text];
}

- (void)autoLogin{
    [self loginWithName:[JusaTool getStrUseKey:UserName] Pwd:[JusaTool getStrUseKey:UserPwd]];
}


- (void)loginWithName:(NSString*)name Pwd:(NSString*)pwd{
    RequestLoginUser *request = [[RequestLoginUser alloc] init];
    request.loginNumber = name;
    request.password = pwd;

    [MBProgressHUD showMessage:@"登录中..." toView:self.view];
//    [NetTool login:request success:^(ResponseLoginUser *user) {
//        [MBProgressHUD hideHUDForView:self.view];
//        if (user.base.success) {
//            [JusaTool saveUser:user];
//            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//            [def setBool:YES forKey:Log_In];
//            [def setObject:UserPwd forKey:pwd];
//            [def setObject:UserName forKey:name];
//            [def synchronize];
//            //环信是否自动登录
////            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
////            if (!isAutoLogin) {
//                //登录环信
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    EMError *error = [[EMClient sharedClient] loginWithUsername:user.loginName password:[JusaTool md5:@"123456"]];
//                    if (!error) {
//                        Print(@"环信登录成功");
//                        //设置环信自动登录
//                        [[EMClient sharedClient].options setIsAutoLogin:YES];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
//                        if (!error) {
//                            NSLog(@"添加成功");
//                        }
//                    }else{
//                        Print(@"环信登录失败");
//                    }
//                    //通知主线程刷新
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //回调或者说是通知主线程刷新，
//                    });
//                });
//
//
////            }
//            [self dismissViewControllerAnimated:YES completion:^{
//
//            }];
//        }else{
//            NSString *msg = user.base.msg;
//            [MBProgressHUD showError:msg];
//        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:Login_sucess object:nil];
//
//    } failure:^(NSError *erro) {
//        [MBProgressHUD hideHUDForView:self.view];
//    }];
}



#pragma mark delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _nameFiled) {
        [_nameFiled resignFirstResponder];
        [_pwdFuled becomeFirstResponder];
    }else{
        [_pwdFuled resignFirstResponder];
        [self login];
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//点击
-(void)doTapChange:(UITapGestureRecognizer *)sender{
    [_nameFiled resignFirstResponder];
    [_pwdFuled resignFirstResponder];
}

@end
