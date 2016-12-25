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

@interface HWEmotionKeyboard()
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
        tabbar.backgroundColor = HWRandomColor;
        [self addSubview: tabbar];
        self.tabbar = tabbar;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // tabbar
    self.tabbar.width = self.width;
    self.tabbar.height = 44;
    self.tabbar.x = 0;
    self.tabbar.y = self.height - self.tabbar.height;
    
    // 表情内容
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabbar.y;
}

@end
