//
//  HWEmotionPageView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionPageView.h"
#import "HWEmotion.h"

@implementation HWEmotionPageView

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        HWEmotion *emotion = emotions[i];
        if(emotion.png){ // 有 png
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        } else if(emotion.code){ // 有 code
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:32]];
        }
        [self addSubview:btn];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    int padding = 15; // 内边距
    CGFloat btnWidth = (self.width - 2 * padding) / HWEmotionMaxCols;
    CGFloat btnHeight = (self.height - padding) / HWEmotionMaxRows;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnWidth;
        btn.height = btnHeight;
        btn.x = padding + (i % HWEmotionMaxCols) * btnWidth;
        btn.y = padding + (i / HWEmotionMaxCols) * btnHeight;
    }
}

@end

