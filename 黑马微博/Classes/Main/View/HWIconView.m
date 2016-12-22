//
//  HWIconView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"

@interface HWIconView()
@property (nonatomic, weak) UIImageView *verifiedView;
@end

@implementation HWIconView

-(UIImageView *)verifiedView{
    if (!_verifiedView) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        _verifiedView = iconView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setUser:(HWUser *)user{
    _user = user;
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    // 设置加V 图片
    switch (user.verified_type) {
        case HWUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case HWUserVerifiedOrgWebsite:
        case HWUserVerifiedOrgMedia:
        case HWUserVerifiedOrgEnterprice: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case HWUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_grassroot"]];
            break;
        default:                // 没有认证
            self.verifiedView.hidden = YES;
            break;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat scale = 0.6;
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}

@end
