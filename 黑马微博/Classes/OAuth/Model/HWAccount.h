//
//  HWAccount.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject<NSCoding>

/**用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据。*/
@property (nonatomic,copy) NSString *access_token;

/**access_token的生命周期，单位是秒数。*/
@property (nonatomic,copy) NSNumber *expires_in;

/**授权用户的UID。*/
@property (nonatomic,copy) NSString *uid;

/**access token 创建时间（获取时间）*/
@property (nonatomic, strong) NSDate *create_time;

/**用户昵称*/
@property (nonatomic, strong) NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
