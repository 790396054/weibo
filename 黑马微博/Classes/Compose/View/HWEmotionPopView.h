//
//  HWEmotionPopView.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  点击表情弹出的提示控件

#import <UIKit/UIKit.h>
@class HWEmotion, HWEmotionButton;

@interface HWEmotionPopView : UIView
+(instancetype)popView;
-(void)popBtnFrom:(HWEmotionButton *)button;
@end
