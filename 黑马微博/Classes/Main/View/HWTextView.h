//
//  HWTextView.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  增强版的 textView 带有 placeholder 占位字符

#import <UIKit/UIKit.h>

@interface HWTextView : UITextView
/**占位文字*/
@property (nonatomic, copy) NSString *placeholder;
/**占位文字颜色*/
@property (nonatomic, strong) UIColor *placeholderColor;
@end
