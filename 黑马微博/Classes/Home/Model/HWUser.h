//
//  HWUser.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

typedef enum {
    HWUserVerifiedTypeNone = -1, // 没有任何认证
    
    HWUserVerifiedPersonal = 0,  // 个人认证
    
    HWUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    HWUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    HWUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    HWUserVerifiedDaren = 220 // 微博达人
}HWUserVerifiedType;

@interface HWUser : NSObject
/**字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/**友好显示名称*/
@property (nonatomic, copy) NSString *name;
/**用户头像地址（中图）*/
@property (nonatomic, copy) NSString *profile_image_url;
/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
/** 认证类型*/
@property (nonatomic, assign) HWUserVerifiedType verified_type;
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end
