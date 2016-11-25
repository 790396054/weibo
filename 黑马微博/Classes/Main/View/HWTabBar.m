//
//  HWTabBar.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWTabBar.h"

@interface HWTabBar()
@property (nonatomic, weak) UIButton *button;
@end

/**
 自定义UITabBar
 */
@implementation HWTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        self.button = plusBtn;
        [self addSubview:plusBtn];
    }
    return self;
}

/**
  加号按钮点击
 */
-(void)plusClick{
    if ([self.hwDelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.hwDelegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.button.centerX = self.size.width * 0.5;
    self.button.centerY = self.size.height *0.5;
    
    int tabBarWidth = 0;
    int tabBarIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = self.width / 5;
            child.x = tabBarWidth;
            tabBarWidth += child.width;
            tabBarIndex ++;
            if (tabBarIndex == 2) {
                tabBarWidth += child.width;
            }
        }
    }
}

@end
