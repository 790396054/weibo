//
//  HWTabBar.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWTabBar;

@protocol HWTabBarDelegate <UITabBarDelegate>
@optional
-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;
@end

@interface HWTabBar : UITabBar
@property (nonatomic, weak) id<HWTabBarDelegate> hwDelegate;
@end
