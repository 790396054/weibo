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
        UIView *originalView = [[UIView alloc] init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        /**用户头像*/
        UIImageView *iconView = [[UIImageView alloc] init];
        [originalView addSubview:iconView];
        self.iconView = iconView;
        
        /**用户昵称*/
        UILabel *nameLabel = [[UILabel alloc] init];
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /**会员标识图片*/
        UIImageView *vipView = [[UIImageView alloc] init];
        [originalView addSubview:vipView];
        self.vipView = vipView;
        
        /**时间*/
        UILabel *timeLabel = [[UILabel alloc] init];
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /**来源*/
        UILabel *sourceLabel = [[UILabel alloc] init];
        [originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /**正文*/
        UILabel *contentLabel = [[UILabel alloc] init];
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /**图片*/
        UIImageView *photoView = [[UIImageView alloc] init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
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
    self.vipView.frame = statusFrame.vipViewF;
    self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    
    /**时间*/
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = @"2016-12-01";
    
    /**来源*/
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = @"来自上古神机 MIX";
    
    /**正文*/
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    /**图片*/
    self.photoView.frame = statusFrame.photoViewF;
    self.photoView.backgroundColor = [UIColor greenColor];
    
    /**原创微博整体*/
    self.originalView.frame = statusFrame.originalViewF;
    
}

@end
