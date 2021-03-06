//
//  HWTabBarController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWTabBarController.h"
#import "HWHomeViewController.h"
#import "HWMessageCenterTableViewController.h"
#import "HWDiscoverViewController.h"
#import "HWProfileViewController.h"
#import "HWNavigationController.h"
#import "HWTabBar.h"
#import "HWComposeViewController.h"

@interface HWTabBarController () <HWTabBarDelegate>

@end

@implementation HWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化子控制器
    HWHomeViewController *home = [[HWHomeViewController alloc] init];
    [self addChildVc:home WithTitle:@"首页" Image:@"tabbar_home" SelectedImage:@"tabbar_home_selected"];
    
    HWMessageCenterTableViewController *messageCenter = [[HWMessageCenterTableViewController alloc] init];
    [self addChildVc:messageCenter WithTitle:@"消息" Image:@"tabbar_message_center" SelectedImage:@"tabbar_message_center_selected"];
    
    HWDiscoverViewController *discover = [[HWDiscoverViewController alloc] init];
    [self addChildVc:discover WithTitle:@"发现" Image:@"tabbar_discover" SelectedImage:@"tabbar_discover_selected"];
    
    HWProfileViewController *profile = [[HWProfileViewController alloc] init];
    [self addChildVc:profile WithTitle:@"我" Image:@"tabbar_profile" SelectedImage:@"tabbar_profile_selected"];
    
    // 2.替换掉系统的UITabBarButton
    HWTabBar *tabbar = [[HWTabBar alloc] init];
    tabbar.hwDelegate = self;
    [self setValue:tabbar forKeyPath:@"tabBar"];
}

#pragma mark - HWTabBarDelegate代理方法
-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar{
    //UIViewController *vc = [[UIViewController alloc] init];
    //vc.view.backgroundColor = [UIColor redColor];
    HWComposeViewController *vc = [[HWComposeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 * 添加子控制器
 */
-(void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectdImage{
//    childVc.tabBarItem.title = title;
//    childVc.navigationItem.title = title;
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectdImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:HWRGBColor(123, 123, 123) forKey:NSForegroundColorAttributeName];
    [childVc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedDict = [[NSMutableDictionary alloc] init];
    [selectedDict setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [childVc.tabBarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器，包装一个导航控制器 自定义导航控制器
    HWNavigationController *nav = [[HWNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:nav];
}

@end
