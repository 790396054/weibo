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

@interface HWHomeViewController () <HWDropdownMenuDelegate>

/**
 微博数组，里面放的每一个模型都是一条微博
 */
@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation HWHomeViewController

-(NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
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
}

/**
 集成上拉加载刷新控件
 */
-(void)setupUpRefresh{
    self.tableView.tableFooterView = [HWLoadFooterView footer];
    
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

/**
 刷新数据

 @param control 刷新控件
 */
-(void)refreshStatus:(UIRefreshControl *)control{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    HWStatus *status = [self.statuses firstObject];
    param[@"access_token"] = account.access_token;
    param[@"since_id"] = status.idstr;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典转模型
        NSArray *array = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range = NSMakeRange(0, array.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:array atIndexes:indexSet];
        // 刷新表格
        [self.tableView reloadData];
        // 取消刷新加载图标
        [control endRefreshing];
        // 显示最新的微博数量
        [self showNewsStatusCount:array.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
  显示最新的微博数量

 @param count 微博数量
 */
-(void)showNewsStatusCount:(NSUInteger)count{
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
//        HWLog(@"失败%@", error);
    }];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSString *strURL = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",account.access_token,account.uid];
//    NSURL *url = [NSURL URLWithString:strURL];
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//       NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",dict);
//        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
//        NSString *name = dict[@"name"];
//        [titleBtn setTitle:name forState:UIControlStateNormal];
//    }];
//    
//    // 开启任务
//    [task resume];
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
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 取出这行对应的微博字典
    HWStatus *status = self.statuses[indexPath.row];
    // 取出这条微博的作者
    HWUser *user = status.user;
    cell.textLabel.text = user.name;
    // 设置微博的文字
    cell.detailTextLabel.text = status.text;
    // 设置头像
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholder];
    return cell;
}

@end
