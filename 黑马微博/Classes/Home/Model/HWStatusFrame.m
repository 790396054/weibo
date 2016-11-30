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

#define HWStatusCellMargin 10

@implementation HWStatusFrame

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    return [self sizeWithText:text font:font maxWidth:MAXFLOAT];
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(void)setStatus:(HWStatus *)status{
    _status = status;
    
    HWUser *user = self.status.user;
    // cell 的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    /*原创微博*/
    /**用户头像*/
    CGFloat iconWH = 40;
    CGFloat iconX = HWStatusCellMargin;
    CGFloat iconY = HWStatusCellMargin;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /**用户昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HWStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY},nameSize};
    
    /**会员标识图片*/
    if (user.vip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HWStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /**时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HWStatusCellMargin;
    CGSize timeSize = [self sizeWithText:status.created_at font:HWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /**来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HWStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:HWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /**正文*/
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.nameLabelF)) + HWStatusCellMargin;
    CGFloat maxWidth =  cellWidth - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:HWStatusCellContentFont maxWidth:maxWidth];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /**图片*/
    CGFloat originH = 0;
    if (status.pic_urls) { // 有配图
        CGFloat photoX = iconX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + HWStatusCellMargin;
        CGFloat photoW = 100;
        self.photoViewF = CGRectMake(photoX, photoY, photoW, photoW);
        originH = CGRectGetMaxY(self.photoViewF) + HWStatusCellMargin;
    } else { // 无配图
        originH = CGRectGetMaxY(self.contentLabelF) + HWStatusCellMargin;
    }
    
    /**原创微博整体*/
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = cellWidth;
    self.originalViewF = CGRectMake(originX, originY, originW, originH);
    
    /**cell 的高度*/
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
}
@end
