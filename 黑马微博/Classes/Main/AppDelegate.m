//
//  AppDelegate.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/21.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "AppDelegate.h"
#import "HWTabBarController.h"
#import "HWNewFeatureViewController.h"
#import "HWOAuthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置根控制器
//    self.window.rootViewController = [[HWTabBarController alloc] init];
    self.window.rootViewController = [[HWNewFeatureViewController alloc] init];
    
    // 读取沙盒中的版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 取出当前的版本号
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    self.window.rootViewController = [[HWOAuthViewController alloc] init];

    // 判断沙盒中的版本号和当前的版本号
//    if ([currentVersion isEqualToString:lastVersion]) { // 版本一致
//        self.window.rootViewController = [[HWTabBarController alloc] init];
//    }else { // 版本不一致
//        self.window.rootViewController = [[HWNewFeatureViewController alloc] init];
//        // 存储当前版本号到沙盒中
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
