//
//  HWEmotionPageView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionPageView.h"
#import "HWEmotion.h"
#import "HWEmotionPopView.h"
#import "HWEmotionButton.h"

@interface HWEmotionPageView()
/** 点击表情后弹出的放大镜*/
@property (nonatomic, strong) HWEmotionPopView *popView;
/** 删除按钮*/
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation HWEmotionPageView

-(HWEmotionPopView *)popView{
    if (_popView == nil) {
        _popView = [HWEmotionPopView popView];
    }
    return _popView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        HWEmotionButton *btn = [[HWEmotionButton alloc] init];
        [self addSubview:btn];
        // 设置表情
        btn.emotion = emotions[i];
        
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    int padding = 15; // 内边距
    CGFloat btnWidth = (self.width - 2 * padding) / HWEmotionMaxCols;
    CGFloat btnHeight = (self.height - padding) / HWEmotionMaxRows;
    
    for (int i = 0; i < self.emotions.count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnWidth;
        btn.height = btnHeight;
        btn.x = padding + (i % HWEmotionMaxCols) * btnWidth;
        btn.y = padding + (i / HWEmotionMaxCols) * btnHeight;
    }
    
    // 删除按钮
    self.deleteButton.frame = CGRectMake(self.width - padding - btnWidth, self.height - btnHeight, btnWidth, btnHeight);
}

#pragma mark - 监听按钮点击
/**
 监听删除按钮点击
 */
-(void)deleteClick{
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HWEmotionDidDeleteNotification object:nil];
}

/**
 监听表情按钮点击
 @param btn 按钮
 */
-(void)btnClick:(HWEmotionButton *)btn{
    HWLog(@"%@",NSStringFromCGRect(self.deleteButton.frame));
    // 赋值
    self.popView.emotion = btn.emotion;
    
    // 取得最上面的 window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    
    // 计算出被点击的按钮在 window 中的 frame(转换坐标系)
    CGRect btnFrame = [btn convertRect:btn.bounds toView:window];
    
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    // 过会儿将 popView 自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[SelectedEmotion] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:HWEmotionDidSelectedNotification object:nil userInfo:userInfo];
}
@end

