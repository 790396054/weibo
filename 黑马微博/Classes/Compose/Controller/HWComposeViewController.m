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
#import "HWComposePhotosView.h"

@interface HWComposeViewController ()<UITextViewDelegate, HWComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**输入控件*/
@property (nonatomic, weak) HWTextView *textView;
/**键盘上方的工具条*/
@property (nonatomic, weak) HWComposeToolBar *toolbar;
/**照片（添加微博的照片控件）*/
@property (nonatomic, weak) HWComposePhotosView *photosView;
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
    // 添加相册控件
    [self setupPhotosView];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化方法

/**
 添加相册
 */
-(void)setupPhotosView{
    HWComposePhotosView *photosView = [[HWComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height; // 高度随便填写，只要相册中的照片能看到即可
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 * 添加工具条
 */
-(void)setupToolbar{
    HWComposeToolBar *toolbar = [[HWComposeToolBar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    toolbar.delegate = self;
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
    //[textView becomeFirstResponder];
    
    // 文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 键盘改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
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
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 发送图片微博
-(void)sendWithImage{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = [HWAccountTool account].access_token;
    param[@"status"] = self.textView.text;
    
    [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        HWLog(@"发送成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败"];
        HWLog(@"发送失败");
    }];
}

// 发送文字微博
-(void)sendWithoutImage{
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
    HWLog(@"%@",NSStringFromCGRect(keyFrame));
}

#pragma mark - UITextViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - HWComposeToolBarDelegate
-(void)composeToolBar:(HWComposeToolBar *)toolBar type:(HWComposeToolBarClickType)buttonType{
    switch (buttonType) {
        case HWComposeToolBarCamera: // 拍照
            [self openCaera];
            break;
        case HWComposeToolBarPicture: // 相册
            [self openPicture];
            break;
        case HWComposeToolBarMention: // @
            HWLog(@"@");
            break;
        case HWComposeToolBarTrend: // #
            HWLog(@"#");
            break;
        case HWComposeToolBarEmoticon: // 表情
            HWLog(@"表情");
            break;
        default:
            break;
    }
}

#pragma mark - 其他方法
// 打开相机
-(void)openCaera{
    [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
}

// 打开相册
-(void)openPicture{
    [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)openImagePicker:(UIImagePickerControllerSourceType)type{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    HWLog(@"%@", info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
