//
//  HWStatusCell.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/30.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//  自定义微博 cell

#import <UIKit/UIKit.h>
@class HWStatusFrame;

@interface HWStatusCell : UITableViewCell
/**带 frame 的微博模型*/
@property (nonatomic, strong) HWStatusFrame *statusFrame;

/**
 初始化cell
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
