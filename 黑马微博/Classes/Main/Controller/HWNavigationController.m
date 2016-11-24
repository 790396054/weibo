//
//  HWNavigationController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/23.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWNavigationController.h"

@interface HWNavigationController ()

@end

@implementation HWNavigationController

// 类第一次加载的时候调用
+(void)initialize{
    // 设置整个项目所有item的样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通主题
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    // 设置不可用状态的主题
    NSMutableDictionary *disableDict = [NSMutableDictionary dictionary];
    disableDict[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    disableDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    if (self.childViewControllers.count > 1) {
        // 设置导航栏上的内容
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
        // 自动显示和影藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

-(void)more{
    [self popToRootViewControllerAnimated:YES];
}

@end
