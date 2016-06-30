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
#import "UserInfoModel.h"

static NSString *const lbTfCellIdentifier = @"lbTfCell";
static NSString *const verifyCodeCellIdentifier = @"verifyCodeCell";
static NSString *const registerFooterViewIdentifier = @"registerFooterView";
@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UserInfoModel * userInfo;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.userInfo = [[UserInfoModel alloc] init];
    [self tableViewRegister];
    
}

#pragma mark - tableView
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
    [footView.registerButton addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    return footView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        VerifyCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:verifyCodeCellIdentifier];
        [cell.getVerifyCodeButton addTarget:self action:@selector(getVerifyCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.tag = 103;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:cell.textField];
        return cell;

    } else {
        LbTfCell *cell = [tableView dequeueReusableCellWithIdentifier:lbTfCellIdentifier];
        switch (indexPath.row) {
            case 0:{
                cell.titleLabel.text = NSLocalizedString(@"手机号", nil);
                cell.textField.placeholder = NSLocalizedString(@"请输入手机号", nil);
                cell.textField.tag = 100;
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:cell.textField];
            }
                break;
            case 2:{
                cell.titleLabel.text = NSLocalizedString(@"密码", nil);
                cell.textField.placeholder = NSLocalizedString(@"请输入6-20位登录密码", nil);
                cell.textField.tag = 101;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:cell.textField];
            }
                break;
            case 3:{
                cell.titleLabel.text = NSLocalizedString(@"确认密码", nil);
                cell.textField.placeholder = NSLocalizedString(@"请再次输入密码", nil);
                cell.textField.tag = 102;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:cell.textField];
            }
                break;
            default:
                break;
        }
        return cell;

    }
    
}

#pragma mark - buttonAction
- (void)footViewQQLoginBtnAction:(UIButton *)button {
    LoginModel * loginModel = [[LoginModel alloc] init];
    [loginModel QQLogin:self];
}

- (void)footViewWeiXinLoginBtnAction:(UIButton *)button {
    LoginModel * loginModel = [[LoginModel alloc] init];
    [loginModel weiXinLogin:self];
}

- (void)getVerifyCodeButtonAction:(UIButton *)button {
    //TODO: 倒计时
    //TODO: 判断是否填写phone
    
    //获取验证码
    [self.userInfo phoneRegisterCAPTCHABlock:^(NSString *code, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:code preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)footViewRegisterButton:(UIButton *)button {
    
}

#pragma mark - textField
- (void)textFieldEditChanged:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    switch (textField.tag) {
        case 100:{
            self.userInfo.phone = textField.text;
        }
            break;
        case 101:{
            self.userInfo.captcha = textField.text;
        }
            break;
        case 102:{
            self.userInfo.password = textField.text;
        }
            break;
        case 103:{
            [self comparePassword:textField.text];
        }
            break;
        default:
            break;
    }

}

//比较两次密码
- (void)comparePassword:(NSString *)text {
    if (![self.userInfo.password isEqualToString:text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码不一致" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//TODO:注销监听


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
