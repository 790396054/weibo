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
/**微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url*/
@property (nonatomic, strong) NSArray *pic_urls;
/**转发数*/
@property (nonatomic, assign) int reposts_count;
/**评论数*/
@property (nonatomic, assign) int comments_count;
/**表态数*/
@property (nonatomic, assign) int attitudes_count;
/**转发微博*/
@property (nonatomic, strong) HWStatus *retweeted_status;
@end
