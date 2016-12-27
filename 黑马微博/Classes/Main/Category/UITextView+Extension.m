//
//  UITextView+Extension.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

-(void)insertAttributeText:(NSAttributedString *)text{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字
    [attrStr appendAttributedString:self.attributedText];
    
    // 拼接属性文字
    NSUInteger loc = self.selectedRange.location;
    [attrStr insertAttributedString:text atIndex:loc];
    
    // 设置字体
    [attrStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attrStr.length)];

    self.attributedText = attrStr;
    
    // 移动光标
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
