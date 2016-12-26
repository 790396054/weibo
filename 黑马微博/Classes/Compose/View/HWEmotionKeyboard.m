//
//  HWEmotionKeyboard.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionTabBar.h"
#import "HWEmotion.h"
#import "MJExtension.h"

@interface HWEmotionKeyboard() <HWEmotionTabbarDelegate>
/** 容纳表情内容的控件*/
@property (nonatomic, weak) UIView *contentView;
/** 表情内容*/
@property (nonatomic, strong) HWEmotionListView *recentListView;
@property (nonatomic, strong) HWEmotionListView *defaultListView;
@property (nonatomic, strong) HWEmotionListView *emojiListView;
@property (nonatomic, strong) HWEmotionListView *lxhListView;

/** tabbar*/
@property (nonatomic, weak) HWEmotionTabBar *tabbar;
@end

@implementation HWEmotionKeyboard
#pragma mark - 懒加载方法
-(HWEmotionListView *)recentListView{
    if (_recentListView == nil) {
        _recentListView = [[HWEmotionListView alloc] init];
    }
    return _recentListView;
}

-(HWEmotionListView *)defaultListView{
    if (_defaultListView == nil) {
        _defaultListView = [[HWEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultListView.emotions = [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

-(HWEmotionListView *)emojiListView{
    if (_emojiListView == nil) {
        _emojiListView = [[HWEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiListView.emotions = [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

-(HWEmotionListView *)lxhListView{
    if (_lxhListView == nil) {
        _lxhListView = [[HWEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhListView.emotions = [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.contentView内容
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        // 2.tabbar
        HWEmotionTabBar *tabbar = [[HWEmotionTabBar alloc] init];
        [self addSubview: tabbar];
        tabbar.delegate = self;
        self.tabbar = tabbar;
}
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // tabbar
    self.tabbar.width = self.width;
    self.tabbar.height = 37;
    self.tabbar.x = 0;
    self.tabbar.y = self.height - self.tabbar.height;
    
    // 表情内容
    self.contentView.x = 0;
    self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabbar.y;
    
    // 设置 frame
    UIView *childView = [self.contentView.subviews lastObject];
    childView.frame = self.contentView.bounds;
}

#pragma mark - 代理方法
-(void)emotionTabbar:(HWEmotionTabBar *)button didSelectButtonType:(HWEmotionTabbarButtonType)buttonType{
    //移除 contentView 上面显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 根据按钮类型，切换 contentView 上面的listview
    switch (buttonType) {
        case HWEmotionTabbarButtonTypeRecent: // 最近
            HWLog(@"最近");
            [self.contentView addSubview:self.recentListView];
            break;
        case HWEmotionTabbarButtonTypeDefault:{ // 默认
            [self.contentView addSubview:self.defaultListView];
        }
        break;
        case HWEmotionTabbarButtonTypeEmoji:{ // Emoji
            [self.contentView addSubview: self.emojiListView];
        }
        break;
        case HWEmotionTabbarButtonTypeLxh:{ // 浪小花
            [self.contentView addSubview:self.lxhListView];
        }
        break;
    }
    // 重新计算子控件的 frame（setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews方法,重新布局子控件）
    [self setNeedsLayout];
}

@end
