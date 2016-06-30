//
//  GoodsDetailViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/23.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailHeaderView.h"
#import "GoodsDetailTableViewCell.h"
#import "DataService.h"
#import "Pingpp.h"
#import "GoodsPayViewController.h"
#import "SelectBuyTimes.h"

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SelectBuyTimes *selectView;
}

@property (weak, nonatomic) IBOutlet UITableView *goodsDetailTableView;


@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goodsDetailTableView.delegate = self;
    self.goodsDetailTableView.dataSource = self;
    
    
    [self setExtraCellLineHidden:self.goodsDetailTableView];
    [self.goodsDetailTableView registerNib:[UINib nibWithNibName:@"GoodsDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"goodsDetailCell"];
    self.goodsDetailTableView.tableHeaderView = [[GoodsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 393)];
    UIView *joinView = [[UIView alloc]initWithFrame:(CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60))];
    joinView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:joinView];
    UIButton *joinButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    joinButton.frame = CGRectMake(self.view.frame.size.width/2-100, 10, 200, 40);
    joinButton.backgroundColor = [UIColor redColor];
    [joinButton setTitle:@"立即参与" forState:(UIControlStateNormal)];
    joinButton.tintColor = [UIColor whiteColor];
    [joinButton addTarget:self action:@selector(clickJoinButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [joinView addSubview:joinButton];
    
    UIView *separatorView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 2))];
    separatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [joinView addSubview:separatorView];
    
    
    
    
}

- (void)clickJoinButton:(UIButton *)sender{
    NSLog(@"join pay");
//    self.hidesBottomBarWhenPushed = YES;
//    GoodsPayViewController *GoodsPayVC = [[GoodsPayViewController alloc]init];
//    //[self.navigationController showViewController:GoodsPayVC sender:nil];
//    [self.navigationController pushViewController:GoodsPayVC animated:YES];
    
    selectView = [[SelectBuyTimes alloc]init];
    [self.view addSubview:selectView];
    

}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 393;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    GoodsDetailHeaderView *headerView = [[GoodsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 393)];
//    return headerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

//隐藏多余分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    //[tableView setTableHeaderView:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *detailArray = [NSArray arrayWithObjects:@"往期揭晓",@"往期晒单", nil];
    GoodsDetailTableViewCell * cell = [self.goodsDetailTableView dequeueReusableCellWithIdentifier:@"goodsDetailCell"];
    cell.textLabel.text = detailArray[indexPath.row];
    return cell;

//    NSArray *arr = [NSArray arrayWithObjects:@"up",@"dowm", nil];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:arr[indexPath.section]];
//    if ([arr[indexPath.section] isEqualToString:@"up"]) {
//        cell = [self.goodsDetailTableView dequeueReusableCellWithIdentifier:@"goodsDetailCell"];
//        //NSArray *detailArray = [NSArray arrayWithObjects:@"往期揭晓",@"往期晒单", nil];
//        //cell.textLabel.text = detailArray[indexPath.row];
//        
//    }else if([arr[indexPath.section] isEqualToString:@"down"])
//    {
//        cell = [self.goodsDetailTableView dequeueReusableCellWithIdentifier:@"joinCell"];
//        
//    }
//    
//    if ([arr[indexPath.section] isEqualToString:@"up"]) {
//        NSArray *detailArray = [NSArray arrayWithObjects:@"往期揭晓",@"往期晒单", nil];
//        cell.textLabel.text = detailArray[indexPath.row];
//    }else if([arr[indexPath.section] isEqualToString:@"down"]){
//        
//    }
//    
//    return cell;
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
