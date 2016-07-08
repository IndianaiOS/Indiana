//
//  LoginRootViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/23.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "LoginRootViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginRootViewController ()<LoginViewControllerDelegate,RegisterViewControllerDelegate>

@property (strong, nonatomic)LoginViewController *loginVC;
@property (strong, nonatomic)RegisterViewController *registerVC;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation LoginRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    // Do any additional setup after loading the view.
}

- (void)setupSubviews {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    self.loginVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    self.loginVC.delegate = self;
    self.registerVC = (RegisterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"registerViewController"];
    self.registerVC.delegate = self;
    [self.view addSubview:self.registerVC.view];
}

- (void)showLoginVC {
    [self.registerVC.view removeFromSuperview];
    [self.view addSubview:self.loginVC.view];

}

- (void)showRegisterVC {
    [self.loginVC.view removeFromSuperview];
    [self.view addSubview:self.registerVC.view];
}

- (IBAction)leftBarButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)segmentAction:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [self showRegisterVC];
    }else if ([sender selectedSegmentIndex] == 1){
        [self showLoginVC];
    }
}

#define mark - delegate
- (void)dismissViewformLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showRegisterView {
    [self showRegisterVC];
    self.segment.selectedSegmentIndex = 0;
}

- (void)dismissViewformRegister {
    [self dismissViewControllerAnimated:YES completion:nil];
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
