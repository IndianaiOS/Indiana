//
//  PersonalViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalCell.h"
#import "PersonalHeaderView.h"
#import "LoginRootViewController.h"
#import "RechargeRecordViewController.h"

static NSString *const personalCellIdentifier = @"personalCell";
static NSString *const personalHeaderViewIdentifier = @"personalHeaderView";

@interface PersonalViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self tableViewRegister];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;

}

- (void)tableViewRegister {
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:personalCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:personalHeaderViewIdentifier];
    self.tableView.tableFooterView = [[UIView alloc]init];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 0;
    }
    return 210;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UserInfoModel *user = [LocaldData achieveListDataType];
        PersonalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:personalHeaderViewIdentifier];
        [headerView personalheaderView:headerView model:user];
        [headerView.loginBtn addTarget:self
                                action:@selector(headerViewLoginBtnAction:)
                      forControlEvents:UIControlEventTouchUpInside];
        return headerView;
    }
    return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:personalCellIdentifier];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = NSLocalizedString(@"积分", nil);
                break;
            case 1:
                cell.titleLabel.text = NSLocalizedString(@"优惠券", nil);
                break;
            case 2:
                cell.titleLabel.text = NSLocalizedString(@"管理收货地址", nil);
                break;
            default:
                break;
        }

    }else {
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = NSLocalizedString(@"订单记录", nil);
                break;
            case 1:
                cell.titleLabel.text = NSLocalizedString(@"充值记录", nil);
                break;
            case 2:
                cell.titleLabel.text = NSLocalizedString(@"绑定银行卡", nil);
                break;
            default:
                break;
        }
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:

                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
        
    }else {
        switch (indexPath.row) {
            case 0:{
                
            }
                break;
            case 1:{
                RechargeRecordViewController * rechargeRecordVC = [[RechargeRecordViewController alloc] initWithNibName:@"RechargeRecordViewController" bundle:nil];
                [self.navigationController showViewController:rechargeRecordVC sender:nil];
            }
                break;
            case 2:
                break;
            default:
                break;
        }
    }


}

#define mark - button Action
- (void)headerViewLoginBtnAction:(UIButton *)btn {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    
    LoginRootViewController *loginRootVC = (LoginRootViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginRootViewController"];
    UINavigationController *loginRootNC = [[UINavigationController alloc] initWithRootViewController:loginRootVC];
    [self presentViewController:loginRootNC animated:YES completion:nil];
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
