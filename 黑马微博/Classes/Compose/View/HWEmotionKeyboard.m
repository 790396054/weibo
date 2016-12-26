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

@interface HWEmotionKeyboard() <HWEmotionTabbarDelegate>
/** 表情内容*/
@property (nonatomic, weak) HWEmotionListView *listView;
/** tabbar*/
@property (nonatomic, weak) HWEmotionTabBar *tabbar;
@end

@implementation HWEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.表情内容
        HWEmotionListView *listView = [[HWEmotionListView alloc] init];
        listView.backgroundColor = HWRandomColor;
        [self addSubview:listView];
        self.listView = listView;
        
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
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabbar.y;
}

#pragma mark - 代理方法
-(void)emotionTabbar:(HWEmotionTabBar *)button didSelectButtonType:(HWEmotionTabbarButtonType)buttonType{
    switch (buttonType) {
        case HWEmotionTabbarButtonTypeRecent: // 最近
            HWLog(@"最近");
            break;
        case HWEmotionTabbarButtonTypeDefault:{ // 默认
            HWLog(@"默认");
            NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
            NSArray *defaultEmotions = [NSArray arrayWithContentsOfFile:path];
            HWLog(@"%@",defaultEmotions);
        }
        break;
        case HWEmotionTabbarButtonTypeEmoji:{ // Emoji
            NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
            NSArray *emojiEmotions = [NSArray arrayWithContentsOfFile:path];
            HWLog(@"Emoji");
            HWLog(@"%@", emojiEmotions);
        }
        break;
        case HWEmotionTabbarButtonTypeLxh:{ // 浪小花
            NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
            NSArray *lxhEmotions = [NSArray arrayWithContentsOfFile:path];
            HWLog(@"%@",lxhEmotions);
        }
        break;
    }
}

@end
