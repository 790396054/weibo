//
//  HWNavigationController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/23.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWNavigationController.h"
#import "UIView+Extension.h"

@interface HWNavigationController ()

@end

@implementation HWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    if (self.childViewControllers.count > 1) {
        // 左边的按钮
        UIButton *btnBack = [self getCustomButtonByName:@"navigationbar_back" highlightName:@"navigationbar_back_highlighted"];
        [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
        // 右边的按钮
        UIButton *btnMore = [self getCustomButtonByName:@"navigationbar_more" highlightName:@"navigationbar_more_highlighted"];
        [btnMore addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnMore];
    }
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

-(void)more{
    [self popToRootViewControllerAnimated:YES];
}

// 返回自定义按钮
-(UIButton *)getCustomButtonByName:(NSString *)name highlightName:(NSString *)highlightName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return btn;
}

@end
