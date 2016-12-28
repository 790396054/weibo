//
//  HWEmotionTool.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWEmotion;
@interface HWEmotionTool : NSObject
/**
 添加HWEmotion模型数组到沙盒中

 @param emotion 表情模型数组
 */
+(void)addRecentEmotion:(HWEmotion *)emotion;

/**
 返回装着 HWEmotion 模型的数组

 @return 数组
 */
+(NSArray *)recentEmotions;
@end
