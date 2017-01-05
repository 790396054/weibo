//
//  HWStatusTool.h
//  黑马微博
//
//  Created by 弓苗苗 on 2017/1/5.
//  Copyright © 2017年 弓苗苗. All rights reserved.
//  缓存微博数据的工具类

#import <Foundation/Foundation.h>

@interface HWStatusTool : NSObject

/**
 存储微博数据到沙盒中
 
 @param statuses 需要存储的微博
 */
+(void)saveStatuses:(NSArray *)statuses;

/**
 根据请求参数去沙盒中加载缓存微博数据

 @param params <#params description#>
 @return <#return value description#>
 */
+(NSArray *)statusesWithParams:(NSDictionary *)params;
@end
