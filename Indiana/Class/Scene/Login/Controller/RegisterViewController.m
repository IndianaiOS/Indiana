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
{
    int _secondsCountDown; //倒计时总时长
    NSTimer *_countDownTimer;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UserInfoModel *userInfo;
@property (strong, nonatomic) NSString *secondPwd;
@property (strong, nonatomic) VerifyCodeCell *verifyCell;

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
    [footView.registerButton addTarget:self action:@selector(footViewRegisterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return footView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        self.verifyCell = [tableView dequeueReusableCellWithIdentifier:verifyCodeCellIdentifier];
        [self.verifyCell.getVerifyCodeButton addTarget:self action:@selector(getVerifyCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.verifyCell.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.verifyCell.textField.tag = 101;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:self.verifyCell.textField];
        return self.verifyCell;

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
                cell.textField.tag = 102;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:cell.textField];
            }
                break;
            case 3:{
                cell.titleLabel.text = NSLocalizedString(@"确认密码", nil);
                cell.textField.placeholder = NSLocalizedString(@"请再次输入密码", nil);
                cell.textField.tag = 103;
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
    self.verifyCell.getVerifyCodeButton.userInteractionEnabled = NO;
    //设置倒计时总时长
    _secondsCountDown = 60;//60秒倒计时
    //开始倒计时
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    
    //设置倒计时显示的时间
//    [self.verifyCell.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"重新发送（%d）",_secondsCountDown] forState:UIControlStateNormal];

    //TODO: 判断是否填写phone
    
    //获取验证码
    [self.userInfo phoneRegisterCAPTCHABlock:^(NSString *code, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:code preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)footViewRegisterButtonAction:(UIButton *)button {
    [self comparePassword];
    [self.userInfo phoneRegisterBlock:^(UserInfoModel *userInfoModel, NSError *error) {
        //TODO:保存个人信息
        //保存数据
        [LocaldData saveListData:userInfoModel];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)timeFireMethod{
    //倒计时-1
    _secondsCountDown--;
    //修改倒计时标签现实内容
    [self.verifyCell.getVerifyCodeButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"重新发送(%d)", nil),_secondsCountDown] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown==0){
        [_countDownTimer invalidate];
        [self.verifyCell.getVerifyCodeButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"获取验证码", nil)] forState:UIControlStateNormal];
        self.verifyCell.getVerifyCodeButton.userInteractionEnabled = NO;

    }
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
            self.secondPwd = textField.text;
        }
            break;
        default:
            break;
    }

}

//比较两次密码
- (void)comparePassword {
    if (![self.userInfo.password isEqualToString:self.secondPwd]) {
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
