//
//  HWDropdownMenu.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/24.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDropdownMenu : UIView

+(instancetype)menu;

/**
 显示
 */
-(void)show;

/**
 销毁
 */
-(void)dismiss;

/**
 内容
 */
@property (nonatomic, strong) UIView *content;

/**
 内容的控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end
