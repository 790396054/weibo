//
//  NSDate+Extension.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/19.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 判断某个时间是否为今年
 */
-(BOOL)isYear{
    NSCalendar *cal = [NSCalendar currentCalendar];
    // 比较两个日期差值
    NSDateComponents *cmps = [cal components:NSCalendarUnitYear fromDate:self toDate:[NSDate date] options:0];
    return cmps.year == 0;
}

/**
 判断某个时间是否为昨天
 */
-(BOOL)isYestoday{
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *dateStr = [fmt stringFromDate: self];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [cal components:unit fromDate:[fmt dateFromString:dateStr] toDate:[fmt dateFromString:nowStr] options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 判断某个时间是否是今天
 */
-(BOOL)isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}
@end
