//
//  NetTool.m
//  ShenDoc
//
//  Created by 郑国华 on 2017/12/25.
//  Copyright © 2017年 nova. All rights reserved.
//

#import "NetTool.h"


@implementation NetTool

+ (void)login:(RequestLoginUser *)request success:(void (^)(ResponseLoginUser *))success failure:(void (^)(NSError *))failure {
    [NAHttpTool postWithURL:[NSString stringWithFormat:@"%@/api/app/nephrosis/patient/login/doLogin",baseUrl] params:request.mj_keyValues success:^(id responseObject) {
        
    //        NSArray *list = [ResponseLoginUser mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"infor"]];
    //        ResponseLoginUser *response = [[ResponseLoginUser alloc] init];
    //        if (list.count > 0) {
    //            response = [list objectAtIndex:0];
    //        }
    //        response.base = [BaseModel mj_objectWithKeyValues:responseObject];
//        success(response);
        
    } failure:^(NSError *error) {
        Print(@"%@",error.mj_keyValues);
        [MBProgressHUD showError:@"加载失败,稍后重试"];
        failure(error);
        
    }];
    
}


@end
