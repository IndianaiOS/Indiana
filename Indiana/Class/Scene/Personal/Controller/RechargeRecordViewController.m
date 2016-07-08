//
//  RechargeRecordViewController.m
//  Indiana
//
//  Created by Tagcare on 16/7/6.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "RechargeRecordViewController.h"
#import "RechargeRecordCell.h"
#import "RechargeRecordModel.h"

static NSString *const rechargeRecordCellIdentifier = @"rechargeRecordCell";

@interface RechargeRecordViewController ()

@property (strong, nonatomic) NSMutableArray *rechargeListArray;
@property (strong, nonatomic) NSMutableDictionary *parameters;


@end

@implementation RechargeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"充值记录", nil);
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self setupSubviews];
    self.rechargeListArray = [NSMutableArray arrayWithCapacity:5];
    self.parameters =[NSMutableDictionary dictionaryWithDictionary:@{
                                 @"userId":@"ios",
                                 @"pageNumber":@"1",
                                 @"pageSize":@"2"
                                 }];
    [self data];

}

- (void)setupSubviews {
    self.baseTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.baseTableView];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"RechargeRecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"rechargeRecordCell"];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    super.delegate = self;
    [self setupRefresh];

}

- (void)data {
    
    [RechargeRecordModel GETUrl:@""
                     parameters:self.parameters
                          block:^(RechargeRecordListModel *rechargeRecordList, NSError *error) {
                              [self.rechargeListArray addObjectsFromArray:rechargeRecordList.data];
                              [self.baseTableView reloadData];
                          }];
}

- (void)parametersKey:(NSString *)key value:(NSString *)value {
    [self.parameters removeObjectForKey:key];
    [self.parameters setObject:value forKey:key];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rechargeListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:rechargeRecordCellIdentifier];
    RechargeRecordModel *rechargeRecord = self.rechargeListArray[indexPath.row];
    [cell rechargeRecordCell:cell model:rechargeRecord];
    
    return cell;
    
    
}

#pragma mark - 刷新
- (void)reloadNewData {
    [self.rechargeListArray removeAllObjects];
    [self.parameters removeObjectForKey:@"pageNumber"];
    [self.parameters setObject:@"1" forKey:@"pageNumber"];
    [self data];
}

- (void)reloadMoreData {
    NSString *pageNumberValue = self.parameters[@"pageNumber"];
    int pageNumber = [pageNumberValue intValue];
    pageNumber++;
    [self.parameters removeObjectForKey:@"pageNumber"];
    [self.parameters setObject:[NSString stringWithFormat:@"%d",pageNumber] forKey:@"pageNumber"];
    [self data];
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
