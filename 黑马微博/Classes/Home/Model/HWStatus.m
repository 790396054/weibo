//
//  HWStatus.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWStatus.h"
#import "MJExtension.h"
#import "HWPhoto.h"

@implementation HWStatus
-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [HWPhoto class]};
}

/*
 1.今年
 
 1>今天
 * 1分钟内: 刚刚
 * 1分-59分内：xx 分钟前
 * 大于60分钟：xx 小时前
 
 2>昨天
 * 昨天 xx：xx
 
 3>其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 
 */
-(NSString *)created_at{
    // _created_at==Sun Dec 04 22:00:03 +0800 2016
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机,转换这种欧美时间，需要设置 local
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 微博创建时间
    _created_at = @"Sun Dec 19 14:05:03 +0800 2016";
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象，可以方便的比较两个时间的差值
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [cal components:unit fromDate:createDate toDate:now options:0];
    
    NSString *timeStr = @"";
    if ([self isYear:createDate]) { // 今年
        if([self isYestoday:createDate]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            timeStr = [fmt stringFromDate:createDate];
        }else if([self isToday:createDate]){ // 今天
            if(cmps.hour >= 1){ // xx小时前
                timeStr = [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            } else if(cmps.minute >= 1){ // xx分钟前
                timeStr = [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else { // 刚刚
                timeStr = @"刚刚";
            }
        }else { // 今年的其他时间
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            timeStr = [fmt stringFromDate:createDate];
        }
    } else { // 不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        timeStr = [fmt stringFromDate:createDate];
    }
    return timeStr;
}

/**
 判断某个时间是否为今年
 */
-(BOOL)isYear:(NSDate *)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    // 比较两个日期差值
    NSDateComponents *cmps = [cal components:NSCalendarUnitYear fromDate:date toDate:[NSDate date] options:0];
    return cmps.year == 0;
}

/**
 判断某个时间是否为昨天
 */
-(BOOL)isYestoday:(NSDate *)date{
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *dateStr = [fmt stringFromDate: date];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [cal components:unit fromDate:[fmt dateFromString:dateStr] toDate:[fmt dateFromString:nowStr] options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 判断某个时间是否是今天
 */
-(BOOL)isToday:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}
@end
