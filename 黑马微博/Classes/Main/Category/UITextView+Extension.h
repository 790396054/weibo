//
//  UITextView+Extension.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/**
 将属性文字插入到光标所在的位置
 */
-(void)insertAttributeText:(NSAttributedString *)text;
-(void)insertAttributeText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString * attributedText))settingBlock;
@end
