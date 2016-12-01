//
//  HWStatusFrame.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/30.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  一个HWStatusFrame所包含的数据
//  1.存放着一个 cell内部所有子控件的 frame数据
//  2.存放一个 cell 的高度
//  3.存放着一个数据模型 HWStatus
#import <Foundation/Foundation.h>

// 昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define HWStatusCellSourceFont HWStatusCellTimeFont
// 正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:14]
// 转发微博字体
#define HWStatusCellRetweetContentFont [UIFont systemFontOfSize:13]
// 行间距
#define HWStatusCellMargin 10
// cell 之间的间距
#define HWStatusCellHeight 15

@class HWStatus;

@interface HWStatusFrame : NSObject
/**微博数据*/
@property (nonatomic, strong) HWStatus *status;
/**原创微博*/
/**原创微博整体*/
@property (nonatomic, assign) CGRect originalViewF;
/**用户头像*/
@property (nonatomic, assign) CGRect iconViewF;
/**用户昵称*/
@property (nonatomic, assign) CGRect nameLabelF;
/**会员标识图片*/
@property (nonatomic, assign) CGRect vipViewF;
/**时间*/
@property (nonatomic, assign) CGRect timeLabelF;
/**来源*/
@property (nonatomic, assign) CGRect sourceLabelF;
/**正文*/
@property (nonatomic, assign) CGRect contentLabelF;
/**图片*/
@property (nonatomic, assign) CGRect photoViewF;

/**转发微博整体*/
@property (nonatomic, assign) CGRect retweetViewF;
/**转发微博正文+昵称*/
@property (nonatomic, assign) CGRect retweetContentLabelF;
/**转发微博配图*/
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/** 底部工具条*/
@property (nonatomic, assign) CGRect toolbarViewF;

/**cell 的高度*/
@property (nonatomic, assign) CGFloat cellHeight;
@end
