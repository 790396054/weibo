//
//  HWEmotionListView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/25.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionListView.h"
#import "HWEmotionPageView.h"

@interface HWEmotionListView() <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation HWEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 创建 UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.delegate = self;
        // 设置单页滚动
        scrollView.pagingEnabled = YES;
        // 去除水平/垂直方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        self.scrollView = scrollView;
        
        // 2. 创建 UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
//        pageControl.hidesForSinglePage = YES;
        pageControl.backgroundColor = [UIColor whiteColor];
        self.pageControl = pageControl;
        // 设置内部的原点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 1. pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2. scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3. 设置 scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        HWEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;

    }
    // 4.设置 scrollView 的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

// 根据emotions,创建对应个数的表情
-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = (emotions.count + HWEmotionsPageSize - 1) / HWEmotionsPageSize;
    // 1.设置页数
    self.pageControl.numberOfPages = count;
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i < count; i++) {
        HWEmotionPageView *pageView = [[HWEmotionPageView alloc] init];
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * HWEmotionsPageSize;
        NSUInteger length = emotions.count - range.location;
        
        if (length >= HWEmotionsPageSize) {
            range.length = HWEmotionsPageSize;
        } else {
            range.length = length;
        }
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
    [self setNeedsLayout];
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageNum = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int) (pageNum + 0.5);
}

@end
