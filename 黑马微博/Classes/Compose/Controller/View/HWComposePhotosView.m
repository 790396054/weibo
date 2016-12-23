//
//  HWComposePhotosView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/23.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWComposePhotosView.h"

@interface HWComposePhotosView()
@property (nonatomic, strong) NSMutableArray *addedPhotos;
@end

@implementation HWComposePhotosView

-(NSMutableArray *)addedPhotos{
    if (_addedPhotos == nil) {
        _addedPhotos = [NSMutableArray array];
    }
    return _addedPhotos;
}

-(void)addPhoto:(UIImage *)photo{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:photo];
    [self addSubview:imageView];
    // 存储图片
    [self.addedPhotos addObject:photo];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger maxCol = 3;
    NSUInteger count = self.subviews.count;
    CGFloat photoWH = 110;
    CGFloat photoMargin = 15;
    for (NSUInteger i = 0; i < count; i++) {
        UIImageView *image = self.subviews[i];
        NSUInteger col = i % maxCol;
        image.x = col * (photoWH + photoMargin) + photoMargin;
        
        NSUInteger row = i / maxCol;
        image.y = row * (photoWH + photoMargin);
        
        image.width = photoWH;
        image.height = photoWH;
    }
}

-(NSArray *)photos{
    return _addedPhotos;
}

@end
