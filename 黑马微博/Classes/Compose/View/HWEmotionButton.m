//
//  HWEmotionButton.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionButton.h"
#import "HWEmotion.h"

@implementation HWEmotionButton

/**
 当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 当控件是从 xib、storyboard 中创建时，就会调用这个方法
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 初始化方法
 */
-(void)setup{
    [self.titleLabel setFont:[UIFont systemFontOfSize:32]];

    // 按钮高亮的时候，不要去调整图片(不要将图片调整为灰色)
    self.adjustsImageWhenHighlighted = NO;
}

//-(void)setHighlighted:(BOOL)highlighted{
//    
//}

/**
 这个方法在initWithCoder方法调用完毕后调用
 */
//-(void)awakeFromNib{
//    
//}

-(void)setEmotion:(HWEmotion *)emotion{
    _emotion = emotion;
    
    if(emotion.png){ // 有 png，是默认或浪小花表情
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if(emotion.code){ // 有 code,是 Emoji 表情
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}

@end
