//
//  HWDropdownMenu.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/24.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWDropdownMenu;

@protocol HWDropdownMenuDelegate <NSObject>
@optional
-(void)dropDownMenuDidDismiss:(HWDropdownMenu *)menu;
-(void)dropDownMenuDidShow:(HWDropdownMenu *)menu;
@end

@interface HWDropdownMenu : UIView

@property (nonatomic, weak) id<HWDropdownMenuDelegate> delegate;

/**
 显示一个下拉框

 @return 下拉框
 */
+(instancetype)menu;

/**
 显示下拉框
 */
-(void)showFrom:(UIView *)view;

/**
 销毁
 */
-(void)dismiss;

/**
 下拉框中显示的内容
 */
@property (nonatomic, strong) UIView *content;

/**
 内容的控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end
