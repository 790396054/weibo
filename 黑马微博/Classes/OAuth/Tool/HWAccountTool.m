//
//  HWAccountTool.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWAccountTool.h"

#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]

@implementation HWAccountTool

+(void)saveAccount:(HWAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}

+(HWAccount *)account{
    // 从沙盒中获取账户信息
    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile: HWAccountPath];
    if (account == nil) {
        return nil;
    }
    /*判断账号是否过期*/
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *experesTime = [account.create_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    // 比较
    NSComparisonResult reslut = [experesTime compare:now];
    if (reslut != NSOrderedDescending) { // 账户信息过期
        return nil;
    }
    return account;
}

@end
