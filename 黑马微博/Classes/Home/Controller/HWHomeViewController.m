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

@interface HWHomeViewController () <HWDropdownMenuDelegate>

/**
 微博数组，里面放的每一个字典都是一条微博
 */
@property (nonatomic, strong) NSArray *statuses;
@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    // 设置用户信息（用户昵称）
    [self setUserInfo];
    // 获取用户关注的人的最新微博
    [self loadViewNewsWeibo];
}

/**
 获取最新的微博数据
 */
-(void)loadViewNewsWeibo{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    param[@"access_token"] = account.access_token;
//    param[@"count"] = @1;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.statuses = responseObject[@"statuses"];
//        HWLog(@"%@",self.statuses);
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
        NSString *name = responseObject[@"name"];
        [titleBtn setTitle:name forState:UIControlStateNormal];
        
        // 存储昵称
        account.name = name;
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
    NSDictionary *weibo = self.statuses[indexPath.row];
    // 取出这条微博的作者
    NSDictionary *user = weibo[@"user"];
    cell.textLabel.text = user[@"name"];
    // 设置微博的文字
    cell.detailTextLabel.text = weibo[@"text"];
    HWLog(@"%@",weibo[@"text"]);
    return cell;
}

@end
