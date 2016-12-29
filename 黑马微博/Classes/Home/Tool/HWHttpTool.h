//
//  HWHttpTool.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  网络请求工具类

#import <Foundation/Foundation.h>

@class AFMultipartFormData;

@interface HWHttpTool : NSObject

/**
 发送 get 请求

 @param url 请求路劲
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 发送 post 请求
 
 @param url 请求路劲
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
