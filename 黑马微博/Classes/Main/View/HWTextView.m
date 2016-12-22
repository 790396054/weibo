//
//  HWTextView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWTextView.h"

@implementation HWTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 不要设置自己的 delegate 为自己
        //self.delegate = self;
        
        // 通知
        // 当UItextView 的文字发生改变时，UITextView 会发出一个UITextViewTextDidChangeNotification 通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

/**
 文字改变时调用
 */
-(void)textChange{
    
    // 重绘（会重新调用drawRect方法）
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 画文字
    CGFloat x = 6;
    CGFloat y = 10;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
