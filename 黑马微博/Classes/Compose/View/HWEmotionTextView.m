//
//  HWEmotionTextView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionTextView.h"
#import "HWEmotion.h"
#import "HWEmotionAttachment.h"

@implementation HWEmotionTextView

-(void)insertEmotion:(HWEmotion *)emotion{
    if (emotion.code) { // Emoji
        // self.textView insertText 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    } else if(emotion.png){ // 其他表情
        // 加载图片
        HWEmotionAttachment *attach = [[HWEmotionAttachment alloc] init];
        attach.emotion = emotion;
        // 设置尺寸
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -5, attachWH, attachWH);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        [self insertAttributeText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
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

-(NSString *)fullText{
    NSMutableString *fullText = [NSMutableString string];
    // 遍历所有的文字
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        HWEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) { // 表情图片
            [fullText appendString:attach.emotion.chs];
        }else { // 普通文字 、Emoji
            // 获得这二个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    
    return fullText;
}
@end
