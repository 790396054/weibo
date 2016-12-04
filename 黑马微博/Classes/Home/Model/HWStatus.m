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

-(NSString *)created_at{
    // _created_at==Sun Dec 04 22:00:03 +0800 2016
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机,转换这种欧美时间，需要设置 local
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 微博创建时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象，可以方便的比较两个时间的差值
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [cal components:unit fromDate:createDate toDate:now options:0];
    
    HWLog(@"%@",cmps);
    NSString *timeStr = @"";
    if (cmps.year) {
        timeStr = @"";
    } else if(cmps.month){
        
    } else if(cmps.day){
        
    } else if(cmps.hour){
        
    }else if(cmps.minute){
        
    } else {
        timeStr = @"刚刚";
    }
    return timeStr;
}
@end
