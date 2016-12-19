//
//  NSDate+Extension.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/19.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 判断某个时间是否为今年
 */
-(BOOL)isYear;

/**
 判断某个时间是否为昨天
 */
-(BOOL)isYestoday;

/**
 判断某个时间是否是今天
 */
-(BOOL)isToday;
@end
