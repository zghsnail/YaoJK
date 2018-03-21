//
//  NAHttpTool.m
//  8期微博
//
//  Created by apple on 14-9-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NAHttpTool.h"
#import "AFNetworking.h"

@implementation NAHttpTool


+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    // 1.创建AFN管理者
    AFHTTPSessionManager *mange = [AFHTTPSessionManager manager];
    mange.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript" ,@"text/plain",@"text/html",nil];
    [mange GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure{
    // 1.创建AFN管理者
    AFHTTPSessionManager *mange = [AFHTTPSessionManager manager];
    mange.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript" ,@"text/plain",@"text/html",nil];
    Print(@"---NET---\nURL:  %@\nParams:%@",url,params.mj_keyValues);
    // 2.发送请求
    [mange POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Print(@"Response:%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Print(@"Response:%@",error);
        failure(error);
    }];

}


+ (void)postURl:(NSString*)url params:(NSDictionary*)params mark:(NSString*)mark files:(NSArray*)files success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript" ,@"text/plain",@"text/html",nil];
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    Print(@"---NET---\nURL:  %@\nParams:%@",url,params.mj_keyValues);
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < files.count; i++) {
            UIImage *image = files[i];
            //            NSData *data = UIImagePNGRepresentation(upImg);
            //顺便压缩一下
            NSData *data = UIImageJPEGRepresentation(image,0.5);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@-%@%-ld.png",[JusaTool user].loginName,str,(long)i];
            //上传
            /*
             此方法参数
             1. 要上传的[二进制数据]
             2. 对应网站上[upload.php中]处理文件的[字段"file"]
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@%ld",mark,(long)i] fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        // 给Progress添加监听 KVO
        Print(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Print(@"上传成功 %@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        Print(@"上传失败 %@", error);
    }];
}






@end
