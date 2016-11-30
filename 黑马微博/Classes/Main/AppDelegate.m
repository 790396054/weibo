//
//  AppDelegate.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/21.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "AppDelegate.h"
#import "HWOAuthViewController.h"
#import "HWAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置根控制器
    // 获取账户信息
    HWAccount *account = [HWAccountTool account];
    if (account) { // 账户存在，之前已经登录过
        // 切换跟控制器
        [self.window switchRootViewController];
    } else {
        self.window.rootViewController = [[HWOAuthViewController alloc] init];
    }
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// 进入后台调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 向操作系统申请后台运行的资格，能维持多久，是不确定的
   UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
       // 当申请的后台任务时间已经结束(过期)，就会调用这个 block
       
       // 赶紧结束任务
       [application endBackgroundTask:task];
   }];
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

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 取消下载
    [mgr cancelAll];
    // 清理内存
    [mgr.imageCache clearMemory];
}
@end
