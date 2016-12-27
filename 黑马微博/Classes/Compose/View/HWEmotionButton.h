//
//  HWEmotionButton.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  表情按钮（最近，默认，Emoji，浪小花）

#import <UIKit/UIKit.h>
@class HWEmotion;

@interface HWEmotionButton : UIButton
@property (nonatomic, strong) HWEmotion *emotion;
@end
