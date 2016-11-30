//
//  HWStatus.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
@class HWUser;

@interface HWStatus : NSObject
/** 字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;
/** 微博信息内容*/
@property (nonatomic, copy) NSString *text;
/** 微博作者的用户信息*/
@property (nonatomic, strong) HWUser *user;
/**时间*/
@property (nonatomic, copy) NSString *created_at;
/**来源*/
@property (nonatomic, copy) NSString *source;
@end
