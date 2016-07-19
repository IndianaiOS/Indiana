//
//  GoodsPayViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/28.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsPayViewController.h"
#import "PayView.h"
#import "GoodsDetailViewController.h"
#import "DataService.h"
#import "PingPP.h"
#import "PayService.h"

@interface GoodsPayViewController ()
{
    PayView *payView;
    UIAlertController *resultAlert;
}

@end

@implementation GoodsPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *view = [[NSBundle mainBundle] loadNibNamed:@"PayView" owner:self options:nil];
    payView = [view objectAtIndex:0];
    payView.frame =(CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64));
    //[[PayView alloc]initWithFrame:(CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64))];
    [self.view addSubview:payView];
    //[payView.selectPayChannelButton setTitle:@"" forState:(UIControlStateNormal)];
    [payView.selectPayChannelButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [payView.confirmPayButton addTarget:self action:@selector(clickConfirmPayButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    payView.buyTimesLabel.text = [NSString stringWithFormat:@"%@夺宝币",self.buyTimes];
    payView.buyTimesCountLabel.text = [NSString stringWithFormat:@"总计：%@夺宝币",self.buyTimes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeUser:) name:@"paySuccessOrNo" object:nil];
    
}

- (void)clickSelectButton:(UIButton *)sender{
    [payView.selectPayChannelButton setTitle:@"√" forState:(UIControlStateNormal)];
    
}

- (void)clickConfirmPayButton:(UIButton *)sender{
    if (!payView.selectPayChannelButton.titleLabel.text) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择支付方式" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        NSLog(@"调用Ping++sdk进入支付渠道进行交易");
        //    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"ios",@"uid",@"xf",@"nickname",@"男",@"gender",@"http://www.baidu.com",@"avatar",@"1",@"logintype",@"1080*800",@"resolution",@"ios9",@"os",@"v1.0",@"appversion",@"123456",@"deviceid", nil];
        NSString *amount = @"1";//self.buyTimes;
        NSString *client_ip = @"127.0.0.2";
        NSString *channel =@"wx";
        NSString *user_id = @"ios";
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:amount,@"amount",client_ip,@"client_ip",channel,@"channel",user_id,@"user_id", nil];
        //GoodsPayViewController *__weak weakself = self;
        PayService *payService = [[PayService alloc]init];
        [payService payUserPingPP:dic block:^(PayService *payModel) {
            [payService pingPay];
        }];
    }
}

- (void)noticeUser:(id)sender{
    [[DataService sharedClient] POST:@"http://192.168.0.103:8888/api/v1/joinSchedule?payType=1&scheduleId=A1&count=1&push_token=123456789&generalId=1"
                          parameters:@{}
                          completion:^(id response, NSError *error) {
                              NSString * 夺宝号 = [[[response objectForKey:@"data"] objectForKey:@"order"] objectForKey:@"numbers"];
                              NSLog(@"%@",夺宝号);
                          }];
    resultAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功" preferredStyle:(UIAlertControllerStyleAlert)];
    //UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    //[alert addAction:cancelAction];
    [self presentViewController:resultAlert animated:YES completion:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
}

- (void)performDismiss:(id)sender{
    [self dismissViewControllerAnimated:resultAlert completion:nil];
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
