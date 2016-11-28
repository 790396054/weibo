//
//  HWTitleButton.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  标题的按钮

#import "HWTitleButton.h"

@implementation HWTitleButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
        self.imageView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 1.计算 labelView 的 frame
    self.titleLabel.x = self.imageView.x;
    
    // 2.计算imageView的 frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 2;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
