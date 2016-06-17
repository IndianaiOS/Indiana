//
//  BaseViewController.m
//  Indiana
//
//  Created by Tagcare on 16/4/15.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 2.0;

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MJRefresh上下拉
- (void)setupRefresh {
    [self headerRereshing];
    //  [self fooderRereshing];
}

- (void)headerRereshing {
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.baseTableView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

- (void)fooderRereshing {
    
    [self headerRereshing];
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.baseTableView.mj_footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData {
    
    // 模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       // 刷新表格
                       [self.baseTableView reloadData];
                       
                       // 拿到当前的下拉刷新控件，结束刷新状态
                       [self.baseTableView.mj_header endRefreshing];
                   });
    NSLog(@"下拉刷新");
}

- (void)loadMoreData {
    
    // 模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.baseTableView reloadData];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.baseTableView.mj_footer endRefreshing];
    });
    NSLog(@"上拉刷新");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
