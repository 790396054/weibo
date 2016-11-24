//
//  UIBarButtonItem+Extension.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/24.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)Action image:(NSString *)Image highImage:(NSString *)HighImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:Action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:HighImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
@end
