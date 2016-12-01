//
//  HWStatusToolBar.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/1.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  底部工具条

#import <UIKit/UIKit.h>
@class HWStatus;
@interface HWStatusToolBar : UIView
+(instancetype)statusToolBar;

/**微博模型*/
@property (nonatomic, strong) HWStatus *status;
@end
