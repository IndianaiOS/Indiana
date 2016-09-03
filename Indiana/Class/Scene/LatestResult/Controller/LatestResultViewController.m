//
//  LatestResultViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "LatestResultViewController.h"
#import "LastResultTableViewCell.h"
#import "MZTimerLabel.h"

@interface LatestResultViewController ()<UITableViewDelegate,UITableViewDataSource,BaseViewControllerReloadDataDelegate>
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)int countTime;
@property(nonatomic,assign)float msCountTime;
@property(nonatomic,strong)LastResultTableViewCell *lastCell;

@end

@implementation LatestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"最新揭晓";
    
    self.baseTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.baseTableView];
    self.baseTableView.tableFooterView = [[UIView alloc]init];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LastResultTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lastResultCell"];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    super.delegate = self;
    [self setupRefresh];
    
    [self data];
}

- (void)data{
    [[DataService sharedClient] GET:@"http://192.168.0.123:8888/api/v1/schedule?label=0&state=2&pageNumber=1&pageSize=10" parameters:@{} completion:^(id response, NSError *error, NSDictionary *header) {
        self.dataArray = [[response objectForKey:@"data"] objectForKey:@"schedulePage"];
        NSString *time = [[response objectForKey:@"data"] objectForKey:@"localTime"];
        int a = [[time substringWithRange:NSMakeRange(2, 2)] intValue];
        int b = [[time substringFromIndex:2] intValue];
        if (a<5) {
            self.countTime = 500000-b;
        }if (5<=a&&a<15) {
            self.countTime = 1500000-b;
        }if (15<=a&&a<25) {
            self.countTime = 2500000-b;
        }if (25<=a&&a<35) {
            self.countTime = 3500000-b;
        }if (35<=a&&a<45) {
            self.countTime = 4500000-b;
        }if (45<=a&&a<55) {
            self.countTime = 5500000-b;
        }if (55<=a) {
            self.countTime = 6500000-b;
        }
        self.msCountTime = self.countTime-self.countTime/1000*1000;
        self.countTime = self.countTime/100000*60+self.countTime/1000-self.countTime/100000*100;
        
        [self.baseTableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lastCell = [tableView dequeueReusableCellWithIdentifier:@"lastResultCell"];
    self.lastCell.goodsNameLabel.text = [self.dataArray[indexPath.row] objectForKey:@"goodsName"];
    self.lastCell.dateNumber.text = [NSString stringWithFormat:@"期号：%@",[self.dataArray[indexPath.row] objectForKey:@"scheduleNo"]];
    self.lastCell.joinTimes.text = [NSString stringWithFormat:@"本期参与：%@",[self.dataArray[indexPath.row] objectForKey:@"copies"]];
    [self.lastCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.56.181.65:8888%@",[self.dataArray[indexPath.row] objectForKey:@"indexImages"]]] placeholderImage:nil];
    [self.lastCell.countDown setTimerType:(MZTimerLabelTypeTimer)];
    [self.lastCell.countDown setCountDownTime:self.countTime+self.msCountTime/1000];
    self.lastCell.countDown.timeFormat = @"mm:ss:SS";
    [self.lastCell.countDown startWithEndingBlock:^(NSTimeInterval countTime) {
        self.lastCell.countDown.text = @"正在开奖";
    }];
    return self.lastCell;
}

#pragma mark - 刷新
- (void)reloadNewData {
    [self data];
    
}

- (void)reloadMoreData {
    
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
