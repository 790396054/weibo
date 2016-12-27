//
//  HWEmotionTextView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionTextView.h"
#import "HWEmotion.h"

@implementation HWEmotionTextView

-(void)insertEmotion:(HWEmotion *)emotion{
    if (emotion.code) { // Emoji
        // self.textView insertText 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    } else if(emotion.png){ // 其他表情
        // 加载图片
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -5, attachWH, attachWH);
        attach.image = [UIImage imageNamed:emotion.png];
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        [self insertAttributeText:imageStr];
    }
}

/**
 selectedRange:
 1.本来是用来控制textView的文字选中范围
 2.如果是 selectedRange.length 为0，selectedRange.location就是 textView 的光标位置
 
 关于 textView文字的字体：
 1.如果是普通文字(text)，文字大小由textView.font控制
 2.如果是属性文字(attributedText),文字大小不受textView.font控制，应该利用
    NSMutableAttributedString 的 -(void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
 */

@end
