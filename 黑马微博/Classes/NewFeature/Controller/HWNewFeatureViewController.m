//
//  HWNewFeatureViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWNewFeatureViewController.h"

#define NewFeaturePages 4

@interface HWNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation HWNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加ImageView
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < NewFeaturePages; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollView.width;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        if (i == NewFeaturePages - 1) {
            [self addButton:imageView];
        }
    }
    
    // 3.设置scrollView的其他属性
    scrollView.contentSize = CGSizeMake(NewFeaturePages * scrollW, 0);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    // 4.添加UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewFeaturePages;
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 80;
    pageControl.pageIndicatorTintColor = HWRGBColor(198, 198, 198);
    pageControl.currentPageIndicatorTintColor = HWRGBColor(253, 98, 42);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double paneNum = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int) (paneNum + 0.5);
}

/**
 添加开启微博按钮

 @param imageView  imageView
 */
-(void)addButton:(UIImageView *)imageView{
    // 开启imageView的用户交互
    imageView.userInteractionEnabled = YES;
    
    // 添加分享按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    shareBtn.width = 200;
    shareBtn.height = 60;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.7;
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    // 添加开启微博按钮
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = shareBtn.centerY + 60;
    [startBtn setTitle:@"开启微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}


/**
 点击复选框

 @param button 按钮
 */
-(void)checkBoxClick:(UIButton *)button{
    button.selected = !button.isSelected;
}

/**
 点击开启微博

 @param button 按钮
 */
-(void)startWeibo:(UIButton *)button{
    NSLog(@"开始微博");
}
@end
