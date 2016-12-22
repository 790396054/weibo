//
//  HWComposeViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "HWTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HWComposeToolBar.h"

@interface HWComposeViewController ()<UITextViewDelegate>
/**输入控件*/
@property (nonatomic, weak) HWTextView *textView;
/**工具条*/
@property (nonatomic, weak) HWComposeToolBar *toolbar;
@end

@implementation HWComposeViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏内容
    [self setupNav];
    // 添加输入框
    [self setupTextView];
    // 添加工具条
    [self setupToolbar];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化方法
/**
 * 添加工具条
 */
-(void)setupToolbar{
    HWComposeToolBar *toolbar = [[HWComposeToolBar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    // inputAccessoryView 设置显示在键盘顶部的内容 
//    self.textView.inputAccessoryView = toolbar;
    // inputView 设置键盘
    //self.textView.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
}

/**
 * 添加输入控件
 */
-(void)setupTextView{
    HWTextView *textView = [[HWTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:18];
    textView.placeholder = @"发布新鲜事...";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    // 成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出键盘）
    [textView becomeFirstResponder];
    
    // 文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 键盘改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 * 设置导航栏内容
 */
-(void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [[HWAccountTool account] name];
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 50;
        titleView.y = 50;
        titleView.numberOfLines = 0;
        titleView.textAlignment = NSTextAlignmentCenter;
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        // 创建一个带有属性的字符串（字体属性，颜色属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:name]];
        // 添加属性
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}

#pragma mark - 监听方法
/**
 * 取消
 */
-(void)cancel{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 发送
 */
-(void)send{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = [HWAccountTool account].access_token;
    param[@"status"] = self.textView.text;

    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HWLog(@"发送成功");
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HWLog(@"发送失败");
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 监听文字输入
 */
-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

/**
 * 键盘的frame 发生改变时调用（显示、隐藏）
 */
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    /**
     notification.userInfo = {
     // 键盘弹出/隐藏后的 frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 465}, {414, 271}},
     // 键盘弹出/隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     // 键盘弹出/隐藏动画的执行节奏(先快后慢，匀速)
     UIKeyboardAnimationCurveUserInfoKey = 7,
     }
     */
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的 frame
    CGRect keyFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = keyFrame.origin.y - self.toolbar.height;
    }];
}

#pragma mark - UITextViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


@end
