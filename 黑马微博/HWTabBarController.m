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

#define HWRGBColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g)/ 255.0 blue:(b)/ 255.0 alpha:1.0]
#define HWRandomColor HWRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface HWTabBarController ()

@end

@implementation HWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    HWHomeViewController *home = [[HWHomeViewController alloc] init];
    [self addChildVc:home WithTitle:@"首页" Image:@"tabbar_home" SelectedImage:@"tabbar_home_selected"];
    
    HWMessageCenterTableViewController *messageCenter = [[HWMessageCenterTableViewController alloc] init];
    [self addChildVc:messageCenter WithTitle:@"消息" Image:@"tabbar_message_center" SelectedImage:@"tabbar_message_center_selected"];
    
    HWDiscoverViewController *discover = [[HWDiscoverViewController alloc] init];
    [self addChildVc:discover WithTitle:@"发现" Image:@"tabbar_discover" SelectedImage:@"tabbar_discover_selected"];
    
    HWProfileViewController *profile = [[HWProfileViewController alloc] init];
    [self addChildVc:profile WithTitle:@"我" Image:@"tabbar_profile" SelectedImage:@"tabbar_profile_selected"];
}

/**
 * 添加子控制器
 */
-(void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectdImage{
    childVc.view.backgroundColor = HWRandomColor;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
