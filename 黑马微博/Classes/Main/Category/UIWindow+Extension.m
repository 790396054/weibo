//
//  UIWindow+Extension.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HWTabBarController.h"
#import "HWNewFeatureViewController.h"

@implementation UIWindow (Extension)

-(void)switchRootViewController{
    // 读取沙盒中的版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 取出当前的版本号
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    
    //判断沙盒中的版本号和当前的版本号
    if ([currentVersion isEqualToString:lastVersion]) { // 版本一致
        self.rootViewController = [[HWTabBarController alloc] init];
    }else { // 版本不一致
        self.rootViewController = [[HWNewFeatureViewController alloc] init];
        // 存储当前版本号到沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
