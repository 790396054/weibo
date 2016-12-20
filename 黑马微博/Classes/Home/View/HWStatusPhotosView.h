//
//  HWStatusPhotosView.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/19.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  微博配图相册(显示1-9张图片)

#import <UIKit/UIKit.h>

@interface HWStatusPhotosView : UIView
/**
 图片集合
 */
@property (nonatomic, strong) NSArray *photos;
/**
 根据图片的个数计算配图的大小
 */
+(CGSize)sizeWithCount:(NSUInteger)count;

@end
