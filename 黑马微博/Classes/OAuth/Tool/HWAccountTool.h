//
//  HWAccountTool.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
// 账户的工具类，操作账户的存取，判断账户是否过期等操作

#import <Foundation/Foundation.h>
@class HWAccount;

@interface HWAccountTool : NSObject

/**
 存储账号到沙盒中
 
 @param account 账号信息
 */
+(void)saveAccount:(HWAccount *)account;

/**
 从沙盒中返回账户信息

 @return 账户信息(如果 access token 过期，则返回 nil)
 */
+(HWAccount *)account;

@end
