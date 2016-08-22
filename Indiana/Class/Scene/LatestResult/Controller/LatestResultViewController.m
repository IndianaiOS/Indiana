//
//  LatestResultViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "LatestResultViewController.h"
#import "LastResultTableViewCell.h"

@interface LatestResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LatestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"最新揭晓";
    self.lastTableView.delegate = self;
    self.lastTableView.dataSource = self;
    
    [self.lastTableView registerNib:[UINib nibWithNibName:@"LastResultTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lastResultCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LastResultTableViewCell *cell = [self.lastTableView dequeueReusableCellWithIdentifier:@"lastResultCell"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
