//
//  HWDropdownMenu.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/24.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWDropdownMenu.h"

@interface HWDropdownMenu()

/**
 将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;
@end

@implementation HWDropdownMenu

-(UIImageView *)containerView{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *contentView = [[UIImageView alloc] init];
        contentView.image = [UIImage imageNamed:@"popover_background"];
        contentView.height = 217;
        contentView.width = 217;
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        _containerView = contentView;
    }
    return _containerView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 清楚颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)menu{
    return [[self alloc] init];
}

-(void)show{
    // 获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 添加到自己窗口上
    [window addSubview:self];
    
    // 设置尺寸
    self.frame = window.bounds;
}

-(void)dismiss{
    [self removeFromSuperview];
}

-(void)setContent:(UIView *)content{
    _content = content;
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    
    // 调整内容的宽度
    content.width = self.containerView.width - 2 * content.x;
    
    // 设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    
    self.content = contentController.view;
}

@end
