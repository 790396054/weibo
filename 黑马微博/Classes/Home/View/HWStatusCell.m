//
//  HWStatusCell.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/30.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  自定义微博 cell

#import "HWStatusCell.h"
#import "HWStatusFrame.h"
#import "HWUser.h"
#import "HWStatus.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"
#import "HWStatusToolBar.h"

@interface HWStatusCell()
/**原创微博*/
/**原创微博整体*/
@property (nonatomic, weak) UIView *originalView;
/**用户头像*/
@property (nonatomic, weak) UIImageView *iconView;
/**用户昵称*/
@property (nonatomic, weak) UILabel *nameLabel;
/**会员标识图片*/
@property (nonatomic, weak) UIImageView *vipView;
/**时间*/
@property (nonatomic, weak) UILabel *timeLabel;
/**来源*/
@property (nonatomic, weak) UILabel *sourceLabel;
/**正文*/
@property (nonatomic, weak) UILabel *contentLabel;
/**图片*/
@property (nonatomic, weak) UIImageView *photoView;

/**转发微博整体*/
@property (nonatomic, weak) UIView *retweetView;
/**转发微博正文+昵称*/
@property (nonatomic, weak) UILabel *retweetContentLabel;
/**转发微博配图*/
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/**底部工具条*/
@property (nonatomic, weak) HWStatusToolBar *toolbarView;
@end

@implementation HWStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 cell 的初始化方法，一个 cell 只会调用一次
 一般在这里添加所有可能显示的子控件,以及子空间的一次性设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor orangeColor];
        self.selectedBackgroundView = bg;
        
        // 初始化原创微博控件
        [self initOriginStatusCell];
        
        // 初始化转发微博控件
        [self initReweetStatusCell];
        
        // 初始化底部工具条
        [self initToolbarViewCell];
    }
    return self;
}

-(void)setStatusFrame:(HWStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    HWStatus *status = statusFrame.status;
    HWUser *user = status.user;
    
    /**用户头像*/
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /**用户昵称*/
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /**会员标识图片*/
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *named = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:named];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /**时间*/
    self.timeLabel.frame = statusFrame.timeLabelF;
//    self.timeLabel.text = @"2016-12-01";
    self.timeLabel.text = status.created_at;
    
    /**来源*/
    self.sourceLabel.frame = statusFrame.sourceLabelF;
//    self.sourceLabel.text = @"来自上古神机 MIX";
    self.sourceLabel.text = status.source;
    
    /**正文*/
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    /**图片*/
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        HWPhoto *photo = status.pic_urls[0];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    } else {
        self.photoView.hidden = YES;
    }
    
    /**原创微博整体*/
    self.originalView.frame = statusFrame.originalViewF;
    
    HWStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) { // 有转发微博
        /**转发微博整体*/
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /**转发微博正文+昵称*/
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.text = [NSString stringWithFormat:@"@%@: %@",retweetStatus.user.name, retweetStatus.text];
        
        /**转发微博配图*/
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            HWPhoto *retweetPhoto = retweetStatus.pic_urls[0];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else { // 无转发微博（原创微博）
        self.retweetView.hidden = YES;
    }
    
    /**底部工具条*/
    self.toolbarView.frame = statusFrame.toolbarViewF;
    self.toolbarView.status = status;
}

/**
 初始化转发微博 cell 控件
 */
-(void)initReweetStatusCell{
    /**转发微博整体*/
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = HWRGBColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /**转发微博正文+昵称*/
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = HWStatusCellRetweetContentFont;
    self.retweetContentLabel = retweetContentLabel;
    
    /**转发微博配图*/
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 初始化原创微博 cell 控件
 */
-(void)initOriginStatusCell{
    /**原创微博整体 view*/
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    self.originalView.backgroundColor = [UIColor whiteColor];
    
    /**用户头像*/
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /**用户昵称*/
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    nameLabel.font = HWStatusCellNameFont;
    self.nameLabel = nameLabel;
    
    /**会员标识图片*/
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    /**时间*/
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    timeLabel.font = HWStatusCellTimeFont;
    self.timeLabel = timeLabel;
    
    /**来源*/
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    sourceLabel.font = HWStatusCellSourceFont;
    self.sourceLabel = sourceLabel;
    
    /**正文*/
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    contentLabel.font = HWStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    
    /**图片*/
    UIImageView *photoView = [[UIImageView alloc] init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
}

/**
 初始化底部工具条
 */
-(void)initToolbarViewCell{
    // 底部工具条
    HWStatusToolBar *toolbarView = [HWStatusToolBar statusToolBar];
    [self.contentView addSubview:toolbarView];
    self.toolbarView = toolbarView;
}

@end
