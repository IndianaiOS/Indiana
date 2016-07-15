//
//  OrdersListViewController.m
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrdersListViewController.h"
#import "OrdersCell.h"
#import "OrdersModel.h"
#import "OrdersHeaderView.h"

static NSString *const ordersCellIdentifier = @"ordersCell";
static NSString *const ordersHeaderViewIdentifier = @"ordersHeaderView";

@interface OrdersListViewController ()<OrdersHeaderViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *winningOrdersListArray;
@end

@implementation OrdersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"全部订单", nil);
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    [self setupSubviews];
    self.winningOrdersListArray = [NSMutableArray arrayWithCapacity:5];
    
    [self data:ORDERS_STATE_WINNING];

}

- (void)setupSubviews {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrdersCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ordersCellIdentifier];
    [self.tableView registerClass:[OrdersHeaderView class] forHeaderFooterViewReuseIdentifier:ordersHeaderViewIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)data:(NSString *)state {
    NSMutableDictionary *parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"state":state,
                                                                                @"pageNumber":@"1",
                                                                                  @"pageSize":@"10"}];
    [OrdersModel GETUrl:@""
             parameters:parameters
                  block:^(OrdersListModel *orderList, NSError *error) {
                      self.winningOrdersListArray = orderList.data;
                      [self.tableView reloadData];
                  }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.winningOrdersListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:ordersCellIdentifier];
    OrdersModel *order = self.winningOrdersListArray[indexPath.row];

    [cell ordersCell:cell model:order];
    return cell;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrdersHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ordersHeaderViewIdentifier];
    headerView.delegate = self;
    return headerView;
    
}

- (void)winningButton {
    [self data:ORDERS_STATE_WINNING];
}

- (void)goingButton {
    [self data:ORDERS_STATE_GOING];
}

- (void)announceButton {
    [self data:ORDERS_STATE_ANNOUNCE];
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
