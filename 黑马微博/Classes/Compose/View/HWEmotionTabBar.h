//
//  HWEmotionTabBar.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>
@class HWEmotionTabBar;

typedef enum {
    HWEmotionTabbarButtonTypeRecent, // 最近
    HWEmotionTabbarButtonTypeDefault, // 默认
    HWEmotionTabbarButtonTypeEmoji, // emoji
    HWEmotionTabbarButtonTypeLxh // 浪小花
}HWEmotionTabbarButtonType;

@protocol HWEmotionTabbarDelegate <NSObject>
@optional
-(void)emotionTabbar:(HWEmotionTabBar *)button didSelectButtonType:(HWEmotionTabbarButtonType)buttonType;
@end

@interface HWEmotionTabBar : UIView
@property (nonatomic, weak) id<HWEmotionTabbarDelegate> delegate;
@end
