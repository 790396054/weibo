//
//  UIBarButtonItem+Extension.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/24.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 添加一个Item

 @param target 点击item后调用那个对象的方法
 @param Action 点击item后调用target的那个方法
 @param Image 图片
 @param HighImage 高亮图片
 @return 创建完成的item
 */
+(UIBarButtonItem *) itemWithTarget:(id)target action:(SEL)Action image:(NSString *)Image highImage:(NSString *)HighImage;
@end
