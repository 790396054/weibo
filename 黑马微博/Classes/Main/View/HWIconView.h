//
//  HWIconView.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  头像 View

#import <UIKit/UIKit.h>

@class HWUser;
@interface HWIconView : UIImageView
/**用户信息*/
@property (nonatomic, strong) HWUser *user;
@end
