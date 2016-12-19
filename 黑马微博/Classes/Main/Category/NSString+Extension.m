//
//  NSString+Extension.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/19.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font maxWidth:MAXFLOAT];
}

-(CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
