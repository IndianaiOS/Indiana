//
//  RegisterViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/22.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterFooterView.h"
#import "LbTfCell.h"
#import "VerifyCodeCell.h"
#import "LoginModel.h"

static NSString *const lbTfCellIdentifier = @"lbTfCell";
static NSString *const verifyCodeCellIdentifier = @"verifyCodeCell";
static NSString *const registerFooterViewIdentifier = @"registerFooterView";
@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self tableViewRegister];
    
}

- (void)tableViewRegister {
    [self.tableView registerNib:[UINib nibWithNibName:@"LbTfCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:lbTfCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"VerifyCodeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:verifyCodeCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RegisterFooterView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:registerFooterViewIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 18;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.view.frame.size.height-218-64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    RegisterFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:registerFooterViewIdentifier];
    [footView.QQLoginBtn addTarget:self action:@selector(footViewQQLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView.weiXinLoginBtn addTarget:self action:@selector(footViewWeiXinLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        VerifyCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:verifyCodeCellIdentifier];
        
        return cell;

    } else {
        LbTfCell *cell = [tableView dequeueReusableCellWithIdentifier:lbTfCellIdentifier];
        switch (indexPath.row) {
            case 0:{
                cell.titleLabel.text = NSLocalizedString(@"手机号", nil);
                cell.textField.placeholder = NSLocalizedString(@"请输入手机号", nil);

            }
                break;
            case 2:{
                cell.titleLabel.text = NSLocalizedString(@"密码", nil);
                cell.textField.placeholder = NSLocalizedString(@"请输入6-20位登录密码", nil);
            }
                break;
            case 3:{
                cell.titleLabel.text = NSLocalizedString(@"确认密码", nil);
                cell.textField.placeholder = NSLocalizedString(@"请再次输入密码", nil);
            }
                break;
            default:
                break;
        }
        return cell;

    }
    
}

- (void)footViewQQLoginBtnAction:(UIButton *)button {
    LoginModel * loginModel = [[LoginModel alloc] init];
    [loginModel QQLogin:self];
}

- (void)footViewWeiXinLoginBtnAction:(UIButton *)button {
    LoginModel * loginModel = [[LoginModel alloc] init];
    [loginModel weiXinLogin:self];
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
