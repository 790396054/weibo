//
//  HWOAuthViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"

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
        [self requestAccessToketWithCode:code];
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
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HWLog(@"请求成功,%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HWLog(@"请求失败，%@", error);
    }];
}

@end
