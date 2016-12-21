//
//  HWStatusPhotosView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/19.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWStatusPhotosView.h"
#import "HWPhoto.h"
#import "HWStatusPhotoView.h"

#define HWStatusPhotoWH 110
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count == 4)?2:3)

@implementation HWStatusPhotosView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    int photoCount = (int)photos.count;
    // 创建够用的 imageView
    while (self.subviews.count < photoCount) {
        HWStatusPhotoView *photoView = [[HWStatusPhotoView alloc] init];
        [self addSubview: photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photoCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 影藏
            photoView.hidden = YES;
            
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    int photoCount = (int)self.photos.count;
    int maxRow = HWStatusPhotoMaxCol(photoCount);
    // 设置图片的尺寸和位置
    for (int i = 0; i < photoCount; i++) {
        HWStatusPhotoView *photoView = self.subviews[i];

        int col = i % maxRow;
        photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
        
        int row = i / maxRow;
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }
}

/**
 根据图片的个数计算配图的大小
 */
+(CGSize)sizeWithCount:(NSUInteger)count{
    // 最大列数(一行最多有多少列)
    int maxCol = HWStatusPhotoMaxCol(count);
    // 列数
    NSUInteger cols = (count >= maxCol) ? maxCol : count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    
    // 行数
    NSUInteger rows = (count + maxCol - 1) / maxCol;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
