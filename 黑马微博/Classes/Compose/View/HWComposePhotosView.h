//
//  HWComposePhotosView.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/23.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWComposePhotosView : UIView

/**
 添加照片

 @param photo 照片
 */
-(void)addPhoto:(UIImage *)photo;

/**
 返回添加的图片

 @return 数组
 */
-(NSArray *)photos;
@end
