//
//  HWEmotionListView.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  表情键盘顶部的表情内容（显示所有的表情） scrollView + pageControl

#import <UIKit/UIKit.h>

@interface HWEmotionListView : UIView
/** 表情（里面存放的是HWEmotion模型）*/
@property (nonatomic, strong) NSArray *emotions;
@end
