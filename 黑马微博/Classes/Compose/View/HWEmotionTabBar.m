//
//  HWEmotionTabBar.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionTabBar.h"
#import "HWEmotionTabbarButton.h"

@interface HWEmotionTabBar()
/** 被选中的按钮*/
@property (nonatomic, weak) HWEmotionTabbarButton *selectedButton;
@end

@implementation HWEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtnWithTitle:@"最近" buttonType:HWEmotionTabbarButtonTypeRecent];
        [self setupBtnWithTitle:@"默认" buttonType:HWEmotionTabbarButtonTypeDefault];
        [self setupBtnWithTitle:@"Emoji" buttonType:HWEmotionTabbarButtonTypeEmoji];
        [self setupBtnWithTitle:@"浪小花" buttonType:HWEmotionTabbarButtonTypeLxh];
    }
    return self;
}

/**
 创建一个按钮

 @param title 按钮标题
 @param buttonType 按钮类型
 @return btn
 */
-(HWEmotionTabbarButton *)setupBtnWithTitle:(NSString *)title buttonType:(HWEmotionTabbarButtonType)buttonType{
    // 创建按钮
    HWEmotionTabbarButton *btn = [[HWEmotionTabbarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [self addSubview:btn];
    // 设置标题
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateDisabled];
    
    // 设置背景图
    NSString *image = @"compose_emotion_table_mid";
    NSString *highImage = @"compose_emotion_table_mid_selected";
    if(self.subviews.count == 1){
        image = @"compose_emotion_table_left";
        highImage = @"compose_emotion_table_left_selected";
    } else if(self.subviews.count == 4){
        image = @"compose_emotion_table_right";
        highImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];

    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0; i < count; i++) {
        HWEmotionTabbarButton *btn = self.subviews[i];
        
        btn.width = self.width / count;
        btn.height = self.height;
        btn.x = i * btn.width;
        btn.y = 0;
    }
}

-(void)setDelegate:(id<HWEmotionTabbarDelegate>)delegate{
    _delegate = delegate;
    
    // 选择“默认”按钮
    [self btnClick:[self viewWithTag:HWEmotionTabbarButtonTypeDefault]];
}

/**
 按钮点击的回调方法

 @param btn 被点击的按钮
 */
-(void)btnClick:(HWEmotionTabbarButton *)btn{
    self.selectedButton.enabled = YES;
    btn.enabled = NO;
    self.selectedButton = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabbar:didSelectButtonType:)]) {
        [self.delegate emotionTabbar:self didSelectButtonType:(HWEmotionTabbarButtonType)btn.tag];
    }
}

@end
