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

// 懒加载
-(UIImageView *)containerView{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *contentView = [[UIImageView alloc] init];
        contentView.image = [UIImage imageNamed:@"popover_background"];
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        _containerView = contentView;
    }
    return _containerView;
}

// 调用init方法会自动调用次方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)menu{
    return [[self alloc] init];
}

-(void)showFrom:(UIView *)view{
    // 获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 添加到自己窗口上
    [window addSubview:self];
    
    // 设置尺寸
    self.frame = window.bounds;
    
    // 调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [view convertRect:view.bounds toView:window];
    self.containerView.x = (self.width - self.containerView.width) * 0.5;
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
}

-(void)setContent:(UIView *)content{
    _content = content;
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    
    // 设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    
    self.content = contentController.view;
}

-(void)dismiss{
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end
