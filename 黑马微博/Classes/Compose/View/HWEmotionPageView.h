//
//  HWEmotionPageView.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//   listView 业每一页要显示的表情

#import <UIKit/UIKit.h>

// 一页中最多3行
#define HWEmotionMaxRows 3
// 一行中最多7列
#define HWEmotionMaxCols 7
// 每一页的表情个数
#define HWEmotionsPageSize ((HWEmotionMaxRows * HWEmotionMaxCols) - 1)

@interface HWEmotionPageView : UIView
/** 这一页显示的表情（里面都 HWEmotion 模型） */
@property (nonatomic, strong) NSArray *emotions;
@end
