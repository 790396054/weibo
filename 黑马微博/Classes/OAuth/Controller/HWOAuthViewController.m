//
//  HWOAuthViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "HWTabBarController.h"
#import "HWAccount.h"
#import "HWNewFeatureViewController.h"
#import "MBProgressHUD+MJ.h"

@interface HWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个 UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.用 WebView 加载登录页面
    NSString *urlStr = @"https://api.weibo.com/oauth2/authorize?client_id=374623624&redirect_uri=http://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    [webView loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // 1.取出 URL
    NSString *urlStr = request.URL.absoluteString;
    // 判断是是否为回调地址
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) {
        // 截取 code 后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:fromIndex];
        
        // 利用 code 换取 access token
        [self requestAccessToketWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    return YES;
}

/**
 获取 AccessToken

 @param code request accessToken
 */
-(void)requestAccessToketWithCode:(NSString *)code{
    // 1. 创立 manager
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.拼接请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"374623624" forKey:@"client_id"];
    [param setObject:@"c44b15aa490bbf3ca18ba5a84e8032e0" forKey:@"client_secret"];
    [param setObject:@"authorization_code" forKey:@"grant_type"];
    [param setObject:code forKey:@"code"];
    [param setObject:@"http://www.baidu.com" forKey:@"redirect_uri"];
    
    // 3.发送 post 请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:param
     progress:^(NSProgress * _Nonnull uploadProgress) {
         
     }
    success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        HWLog(@"请求成功,%@", doc);
        NSString *path = [doc stringByAppendingPathComponent:@"account.archiver"];
        // 将返回的账号字典数据 --> 模型，存进沙盒
        HWAccount *account = [HWAccount accountWithDict:responseObject];
        // 自定义对象的存储必须用NSKeyedArchiver，不在有什么writeToFile方法
        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        // 读取沙盒中的版本号
        NSString *key = @"CFBundleVersion";
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        
        // 取出当前的版本号
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        //判断沙盒中的版本号和当前的版本号
        if ([currentVersion isEqualToString:lastVersion]) { // 版本一致
            window.rootViewController = [[HWTabBarController alloc] init];
        }else { // 版本不一致
            window.rootViewController = [[HWNewFeatureViewController alloc] init];
            // 存储当前版本号到沙盒中
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //HWLog(@"请求失败，%@", error);
        [MBProgressHUD hideHUD];
    }];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

@end
