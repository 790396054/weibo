//
//  HWAccount.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount

+(instancetype)accountWithDict:(NSDictionary *)dict{
    HWAccount *account = [[HWAccount alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"access_token"];
    account.uid = dict[@"uid"];
    return account;
}

/**
 当一个对象要归档进沙盒时,就会调用这个方法
 目的：在这个方法中说明这个对象的那些属性要存进沙盒
 */
-(void)encodeWithCoder:(NSCoder *)enoder{
    [enoder encodeObject:self.access_token forKey:@"access_token"];
    [enoder encodeObject:self.expires_in forKey:@"expires_in"];
    [enoder encodeObject:self.uid forKey:@"uid"];
}

/**
 当从沙盒中解档一个对象时（从沙盒中加载一个对象），就会调用这个方法
 目的：在这个方法中说明沙盒中的属性改怎么解析(需要取出那些属性)
 */
-(instancetype)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
