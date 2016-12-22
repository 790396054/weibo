//
//  HWMessageCenterTableViewController.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/22.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWMessageCenterTableViewController.h"
#import "TestViewController.h"

@interface HWMessageCenterTableViewController ()

@end

@implementation HWMessageCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(writeMessage)];
    HWLog(@"%s",__func__);
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

-(void)writeMessage{
    HWLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = @"hmwb";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"哈哈%ld",(long)indexPath.row];
    
    return cell;
}

// 单击tableView的cell，调用此方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TestViewController *viewCon = [[TestViewController alloc] init];
    [self.navigationController pushViewController:viewCon animated:YES];
}

@end
