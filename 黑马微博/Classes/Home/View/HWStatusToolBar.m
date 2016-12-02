//
//  HWStatusToolBar.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/1.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWStatusToolBar.h"

@interface HWStatusToolBar()

@property (nonatomic, strong) NSMutableArray *dividers;
/**转发按钮*/
@property (nonatomic, weak) UIButton *repostBtn;
/**评论按钮*/
@property (nonatomic, weak) UIButton *commentBtn;
/**点赞按钮*/
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation HWStatusToolBar

+(instancetype)statusToolBar{
    return [[self alloc] init];
}

-(NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        // 设置按钮
        self.repostBtn = [self setupBtnWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" icon:@"timeline_icon_unlike"];
        
        // 设置分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 设置分割线
 */
-(void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 设置按钮

 @param title 按钮标题
 @param icon 按钮图标
 */
-(UIButton *)setupBtnWithTitle:(NSString *)title icon:(NSString *)icon{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [btn setTitleColor:HWRGBColor(222, 222, 222) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 设置按钮的 frame
    NSUInteger count = 3;//self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
    }
    
    // 设置分割线的 frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
}

-(void)setStatus:(HWStatus *)status{
    _status = status;
    
    // 转发
    
    // 评论
    
    // 点赞
    
}

@end
