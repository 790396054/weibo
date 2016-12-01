//
//  HWHomeViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWSearchBar.h"
#import "HWDropdownMenu.h"
#import "HWTitleTableViewController.h"
#import "HWAccountTool.h"
#import "AFNetworking.h"
#import "HWTitleButton.h"
#import "UIImageView+WebCache.h"
#import "HWUser.h"
#import "HWStatus.h"
#import "MJExtension.h"
#import "HWLoadFooterView.h"
#import "HWStatusCell.h"
#import "HWStatusFrame.h"

@interface HWHomeViewController () <HWDropdownMenuDelegate>

/**
 微博数组，里面放的每一个模型都是一条微博
 */
@property (nonatomic, strong) NSMutableArray *statuseFrames;
@end

@implementation HWHomeViewController

-(NSMutableArray *)statuseFrames{
    if (_statuseFrames == nil) {
        _statuseFrames = [NSMutableArray array];
    }
    return _statuseFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    // 设置用户信息（用户昵称）
    [self setUserInfo];
    // 集成下拉刷新控件
    [self setupDownRefresh];
    // 集成上拉加载刷新控件
    [self setupUpRefresh];
    // 获得未读数
    [NSTimer scheduledTimerWithTimeInterval:5 * 60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if(version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

/**
 获得未读数
 */
-(void)setupUnreadCount{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    dict[@"access_token"] = account.access_token;
    dict[@"uid"] = account.uid;
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HWLog(@"success:%@",responseObject);
        // 设置未读数
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = [status intValue];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 集成上拉加载刷新控件
 */
-(void)setupUpRefresh{
    HWLoadFooterView *footer = [HWLoadFooterView footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 集成下拉刷新控件
 */
-(void)setupDownRefresh{
    // 添加刷新控件
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    
    // 马上进入刷新状态（仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件）
    [refresh beginRefreshing];
    // 马上加载数据
    [self refreshStatus:refresh];
}

-(NSArray *)statusChangeStatusFrame:(NSArray *)statuses{
    NSMutableArray *frameArray = [NSMutableArray array];
    for (HWStatus *status in statuses) {
        HWStatusFrame *statusFrame = [[HWStatusFrame alloc] init];
        statusFrame.status = status;
        [frameArray addObject:statusFrame];
    }
    return frameArray;
}

/**
 刷新数据

 @param control 刷新控件
 */
-(void)refreshStatus:(UIRefreshControl *)control{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    HWStatusFrame *statusFrame = [self.statuseFrames firstObject];
    param[@"access_token"] = account.access_token;
    param[@"since_id"] = statusFrame.status.idstr;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典转模型
        NSArray *array = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *statusFrame = [self statusChangeStatusFrame:array];
        NSRange range = NSMakeRange(0, statusFrame.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuseFrames insertObjects:statusFrame atIndexes:indexSet];
        // 刷新表格
        [self.tableView reloadData];
        // 取消刷新加载图标
        [control endRefreshing];
        // 显示最新的微博数量
        [self showNewsStatusCount:array.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [control endRefreshing];
    }];
}

/**
 加载更多的微博数据
 */
-(void)loadMoreStatus{
    // 1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    param[@"access_token"] = account.access_token;
    // 取出最后面的微博（最新的微博，id 最大的微博）
    HWStatusFrame *lastStatusFrame = [self.statuseFrames lastObject];
    if (lastStatusFrame) {
        // 若指定此参数，则返回ID 小于或等于 max_id 的微博，默认为0
        // id 这种数据一般是比较大的，一般转成整数的话，最好的 long long 类型
        long long maxId = lastStatusFrame.status.idstr.longLongValue - 1;
        param[@"max_id"] = @(maxId);
    }
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        // 字典转模型
        NSArray *newStatus = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将更多的微博数据，添加到总数组的最后面，
        [self.statuseFrames addObjectsFromArray:[self statusChangeStatusFrame:newStatus]];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新（隐藏footer）
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
    
}

/**
  显示最新的微博数量

 @param count 微博数量
 */
-(void)showNewsStatusCount:(NSUInteger)count{
    // 刷新成功，清空未读数
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // 1.创建一个 label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    // 2.设置其他属性
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    if (count == 0) {
        label.text = @"没有最新的微博，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有最新的%ld条微博",count];
    }
    
    // 3.添加到导航控制器的 view 中，并且是在导航栏的下面
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 4.执行动画
    [UIView animateWithDuration:1.0 animations:^{
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // UIViewAnimationOptionCurveLinear 匀速运动
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

/**
 设置用户信息
 */
-(void)setUserInfo{
    // 获得管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 拼接参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    param[@"access_token"] = account.access_token;
    param[@"uid"] = account.uid;
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary *responseObject) {
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        HWUser *user = [HWUser objectWithKeyValues: responseObject];
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称
        account.name = user.name;
        [HWAccountTool saveAccount:account];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

/**
 设置导航栏
 */
-(void)setUpNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchFrends) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    // 下拉搜索框
    HWTitleButton *button = [[HWTitleButton alloc] init];
    [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    NSString *name = [HWAccountTool account].name;
    [button setTitle:name?name:@"首页" forState:UIControlStateNormal];
    self.navigationItem.titleView = button;
}

/**
  标题点击
 */
-(void)titleClick:(UIButton *)from{
    HWDropdownMenu *menu = [HWDropdownMenu menu];
    menu.delegate = self;
    HWTitleTableViewController *content = [[HWTitleTableViewController alloc] init];
    // 设置宽高
    content.view.height = 44 * 3;
    content.view.width = 150;
    // 设置内容
    menu.contentController = content;
    // 显示
    [menu showFrom:from];
}

#pragma mark - 实现下拉点击的代理方法
-(void)dropDownMenuDidDismiss:(HWDropdownMenu *)menu{
    UIButton *button = (UIButton *)self.navigationItem.titleView;
    button.selected = NO;
}

/**
 显示下拉菜单
 */
-(void)dropDownMenuDidShow:(HWDropdownMenu *)menu{
    UIButton *button = (UIButton *)self.navigationItem.titleView;
    button.selected = YES;
}

-(void)searchFrends{
    NSLog(@"%s",__func__);
}

-(void)pop{
    NSLog(@"%s", __func__);
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuseFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWStatusCell *cell = [HWStatusCell cellWithTableView:tableView];
    
//    // 取出这行对应的微博字典
//    HWStatus *status = self.statuses[indexPath.row];
//    // 取出这条微博的作者
//    HWUser *user = status.user;
//    cell.textLabel.text = user.name;
//    // 设置微博的文字
//    cell.detailTextLabel.text = status.text;
//    // 设置头像
//    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholder];
    cell.statusFrame = self.statuseFrames[indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 如果 tableView 还没有数据，就直接返回
    if (self.statuseFrames.count == 0 || self.tableView.tableFooterView.hidden == NO) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个 cell 完全显示在眼前时，contentOffset 的 y 值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    
   // CGFloat judgeOffsetY1 = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个 cell 完全进入视线内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        // 加载更多微博数据
        [self loadMoreStatus];
        NSLog(@"加载更多");
    }
    /**
     contentInset: 除具体内容以外的边框尺寸
     contetnSize: 里面的具体内容（hander,cell,footer），除掉 contentInset以外的尺寸
     contetnOffset: 
     1.他可以用来判断 scrollView 滚动到什么位置
     2.指 scrollView 的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWStatusFrame *statusframe = self.statuseFrames[indexPath.row];
    return statusframe.cellHeight;
}

@end
