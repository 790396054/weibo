//
//  HWStatusFrame.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/30.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWStatusFrame.h"
#import "HWUser.h"
#import "HWStatus.h"

#define HMStatusCellMargin 10

@implementation HWStatusFrame

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [text sizeWithAttributes:attrs];
}

-(void)setStatus:(HWStatus *)status{
    _status = status;
    
    HWUser *user = self.status.user;
    
    /*原创微博*/
    /**用户头像*/
    CGFloat iconWH = 50;
    CGFloat iconX = HMStatusCellMargin;
    CGFloat iconY = HMStatusCellMargin;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /**用户昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HMStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY},nameSize};
    
    /**会员标识图片*/
    if (user.vip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HMStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /**时间*/
    
    /**来源*/
    
    /**正文*/
    
    /**图片*/
    
    /**原创微博整体*/
    
    /**cell 的高度*/
    self.cellHeight = 100;
}
@end
