//
//  LoginViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/22.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "LoginViewController.h"
#import "LbTfCell.h"
#import "ForgetPwdCell.h"
#import "LoginFooterView.h"

static NSString *const lbTfCellIdentifier = @"lbTfCell";
static NSString *const forgetPwdCellIdentifier = @"forgetPwdCell";
static NSString *const loginFooterViewIdentifier = @"loginFooterView";

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self tableViewRegister];
    
}

- (void)tableViewRegister {
    [self.tableView registerNib:[UINib nibWithNibName:@"LbTfCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:lbTfCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ForgetPwdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:forgetPwdCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginFooterView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:loginFooterViewIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.view.frame.size.height-118-64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    LoginFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:loginFooterViewIdentifier];
    
    return footView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        LbTfCell *cell = [tableView dequeueReusableCellWithIdentifier:lbTfCellIdentifier];
        cell.titleLabel.text = NSLocalizedString(@"手机号", nil);
        cell.textField.placeholder = NSLocalizedString(@"请输入手机号", nil);
        return cell;
        
    } else {
        ForgetPwdCell *cell = [tableView dequeueReusableCellWithIdentifier:forgetPwdCellIdentifier];
        
        return cell;
        
    }
    
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
