//
//  HWOAuthViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWOAuthViewController.h"

@interface HWOAuthViewController ()

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个 UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.用 WebView 加载登录页面
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",@"374623624",@"https://api.weibo.com/oauth2/access_token"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

@end
