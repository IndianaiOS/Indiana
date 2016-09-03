//
//  WinningListViewController.m
//  Indiana
//
//  Created by Tagcare on 16/8/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "WinningListViewController.h"
#import "EditorTextViewController.h"

static NSString *const ordersCellIdentifier = @"ordersCell";

@interface WinningListViewController ()<UITableViewDelegate,UITableViewDataSource,OrdersCellDelegate>

@property (strong, nonatomic) NSMutableArray *winningOrdersListArray;

@end

@implementation WinningListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSLocalizedString(@"中奖订单", nil);
//    self.tabBarController.tabBar.hidden = YES;
//    self.navigationController.navigationBarHidden = NO;
    [self setupSubviews];
    self.winningOrdersListArray = [NSMutableArray arrayWithCapacity:5];
    
    [self data:ORDERS_STATE_WINNING];
}

- (void)setupSubviews {
    
    [self.winningTableView registerNib:[UINib nibWithNibName:@"OrdersCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ordersCellIdentifier];
    self.winningTableView.tableFooterView = [[UIView alloc] init];
    self.winningTableView.delegate = self;
    self.winningTableView.dataSource = self;
    
}

- (void)data:(NSString *)state {
    NSMutableDictionary *parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"state":state,
                                                                                     @"pageNumber":@"1",
                                                                                     @"pageSize":@"10"}];
    [OrdersModel GETUrl:@""
             parameters:parameters
                  block:^(OrdersListModel *orderList, NSError *error) {
                      self.winningOrdersListArray = orderList.data;
                      [self.winningTableView reloadData];
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
    cell.delegate = self;
    OrdersModel *order = self.winningOrdersListArray[indexPath.row];
    cell.viewNumberBtn.tag = 100+indexPath.row;
    [cell ordersCell:cell model:order];
    [cell.buyAgainBtn setTitle:@"晒单" forState:(UIControlStateNormal)];
    
    return cell;
    
    
}

- (void)viewNumberButton:(UIButton *)sender {
    OrdersModel * order = self.winningOrdersListArray[sender.tag-100];
    NSString * message = [order.numbers stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"夺宝号为：" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//此处是晒单
- (void)buyAgainButton {
    EditorTextViewController *editorVC = [[EditorTextViewController alloc]init];
    [self.navigationController showViewController:editorVC sender:nil];
}

- (void)winnerButton {
    
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
