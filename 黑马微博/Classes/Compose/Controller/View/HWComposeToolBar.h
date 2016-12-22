//
//  HWComposeToolBar.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  发微博工具条

#import <UIKit/UIKit.h>

typedef enum {
    HWComposeToolBarCamera, // 拍照
    HWComposeToolBarPicture, // 相册
    HWComposeToolBarMention, // @
    HWComposeToolBarTrend, // #
    HWComposeToolBarEmoticon // 表情
} HWComposeToolBarClickType;

@class HWComposeToolBar;

@protocol HWComposeToolBarDelegate <NSObject>
@optional
-(void)composeToolBar:(HWComposeToolBar *)toolBar type:(HWComposeToolBarClickType)buttonType;
@end

@interface HWComposeToolBar : UIView
@property (nonatomic, weak) id<HWComposeToolBarDelegate> delegate;
@end
