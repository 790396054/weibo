//
//  HWComposeToolBar.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWComposeToolBar.h"

@implementation HWComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self createBtn:@"compose_camerabutton_background" highlight:@"compose_camerabutton_background_highlighted" type:HWComposeToolBarCamera];
        [self createBtn:@"compose_toolbar_picture" highlight:@"compose_toolbar_picture_highlighted" type:HWComposeToolBarPicture];
        [self createBtn:@"compose_mentionbutton_background" highlight:@"compose_mentionbutton_background_highlighted" type:HWComposeToolBarMention];
        [self createBtn:@"compose_trendbutton_background" highlight:@"compose_trendbutton_background_highlighted" type:HWComposeToolBarTrend];
        [self createBtn:@"compose_emoticonbutton_background" highlight:@"compose_emoticonbutton_background_highlighted" type:HWComposeToolBarEmoticon];
    }
    return self;
}

// 创建按钮
-(void)createBtn:(NSString *)image highlight:(NSString *)highlight type:(HWComposeToolBarClickType)type{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnWidth = self.width / count;
    CGFloat btnHeight = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnWidth;
        btn.height = btnHeight;
        btn.x = i * btnWidth;
        btn.y = 0;
    }
}

-(void)btn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:type:)]) {
        [self.delegate composeToolBar:self type:btn.tag];
    }
}

@end
