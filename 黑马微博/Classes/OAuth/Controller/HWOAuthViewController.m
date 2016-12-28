//
//  HWOAuthViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "HWHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "HWAccountTool.h"

@interface HWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    
    [[UIDevice currentDevice] systemVersion];
    
    [super viewDidLoad];
    
    // 1.创建一个 UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.用 WebView 加载登录页面
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",HWAppKey, HWRedirectUri];
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
    // 1.拼接请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:HWAppKey forKey:@"client_id"];
    [param setObject:HWClientSecret forKey:@"client_secret"];
    [param setObject:@"authorization_code" forKey:@"grant_type"];
    [param setObject:code forKey:@"code"];
    [param setObject:HWRedirectUri forKey:@"redirect_uri"];
    
    // 3.发送 post 请求
    [HWHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:param success:^(id json) {
        [MBProgressHUD hideHUD];
        // 将返回的账号字典数据 --> 模型，存进沙盒
        HWAccount *account = [HWAccount accountWithDict:json];
        // 自定义对象的存储必须用NSKeyedArchiver，不在有什么writeToFile方法
        [HWAccountTool saveAccount:account];
        
        // 切换控制器
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window switchRootViewController];
    } failure:^(NSError *error) {
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
