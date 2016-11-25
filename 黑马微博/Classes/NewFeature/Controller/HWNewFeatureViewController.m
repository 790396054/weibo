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

@end
