//
//  HWUser.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

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
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end
