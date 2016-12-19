//
//  NSString+Extension.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/19.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font;

-(CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
@end
