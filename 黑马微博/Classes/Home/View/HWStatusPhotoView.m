//
//  HWStatusPhotoView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/21.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"

@interface HWStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation HWStatusPhotoView

-(UIImageView *)gifView{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setPhoto:(HWPhoto *)photo{
    _photo = photo;
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString: photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![self.photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
