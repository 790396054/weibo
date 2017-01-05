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

-(NSInteger)fileSize{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件/文件夹不存在
    if(exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历self里面的所有内容 --直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL subDir = NO;
            [mgr fileExistsAtPath:fullpath isDirectory:&subDir];
            if (subDir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

@end
