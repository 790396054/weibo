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

@interface HWHomeViewController () <HWDropdownMenuDelegate>

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchFrends) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    // 下拉搜索框
    UIButton *button = [[UIButton alloc] init];
    button.height = 30;
    button.width = 100;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"首页" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    self.navigationItem.titleView = button;
}

/**
  标题点击
 */
-(void)titleClick:(UIButton *)from{
    HWDropdownMenu *menu = [HWDropdownMenu menu];
    menu.delegate = self;
    HWTitleTableViewController *conte = [[HWTitleTableViewController alloc] init];
    // 设置宽高
    conte.view.height = 44 * 3;
    conte.view.width = 150;
    // 设置内容
    menu.contentController = conte;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
