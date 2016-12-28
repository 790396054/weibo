//
//  HWEmotionTool.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionTool.h"
#import "HWEmotion.h"

// 最近表情的存储路径
#define HWRecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archiver"]

@implementation HWEmotionTool

static NSMutableArray *_recentEmotions;

+(void)initialize{
    // 加载沙盒中的表情数据
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HWRecentEmotionPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

/**
 添加HWEmotion模型数组到沙盒中
 
 @param emotion 表情模型数组
 */
+(void)addRecentEmotion:(HWEmotion *)emotion{
    // 删除重复的表情
    for (int i = 0; i < _recentEmotions.count; i++) {
        HWEmotion *e = _recentEmotions[i];
        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
            [_recentEmotions removeObject:e];
            break;
        }
    }
    
    //将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:HWRecentEmotionPath];
}

/**
 返回装着 HWEmotion 模型的数组
 
 @return 数组
 */
+(NSArray *)recentEmotions{
    return _recentEmotions;
}
@end
