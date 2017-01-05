//
//  NSString+Extension.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/19.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 根据传入的字体计算占用位置的尺寸

 @param font 字体
 @return 尺寸
 */
-(CGSize)sizeWithFont:(UIFont *)font;

-(CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 计算文件/文件夹的大小

 @return byte字节大小
 */
-(NSInteger)fileSize;
@end
