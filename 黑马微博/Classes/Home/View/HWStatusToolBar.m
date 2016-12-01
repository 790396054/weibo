//
//  HWStatusToolBar.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/1.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWStatusToolBar.h"

@implementation HWStatusToolBar

+(instancetype)statusToolBar{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtnWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        [self setupBtnWithTitle:@"评论" icon:@"timeline_icon_comment"];
        [self setupBtnWithTitle:@"赞" icon:@"timeline_icon_unlike"];
    }
    return self;
}

/**
 设置按钮

 @param title 按钮标题
 @param icon 按钮图标
 */
-(void)setupBtnWithTitle:(NSString *)title icon:(NSString *)icon{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:btn];
}

-(void)layoutSubviews{
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
    }
}

@end
