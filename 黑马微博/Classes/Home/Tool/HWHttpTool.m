//
//  HWHttpTool.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  网络请求工具类

#import "HWHttpTool.h"
#import "AFNetworking.h"

@implementation HWHttpTool

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError * error))failure{
    // 1.创建 AFN 管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 1.创建 AFN 管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
