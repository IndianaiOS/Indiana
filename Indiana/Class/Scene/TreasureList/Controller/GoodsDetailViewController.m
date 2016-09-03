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
#import "GoodsModel.h"
#import "EverJoinTableViewCell.h"

static NSString *everJoinUrl = @"http://192.168.0.123:8888/api/v1/scheduleOrders/A1?pageNumber=1&pageSize=10";

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    SelectBuyTimes *selectView;
}

@property (weak, nonatomic) IBOutlet UITableView *goodsDetailTableView;
@property(nonatomic, strong)NSArray *userArray;

@end

@implementation GoodsDetailViewController

- (void)viewWillDisappear:(BOOL)animated{
    selectView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goodsDetailTableView.delegate = self;
    self.goodsDetailTableView.dataSource = self;
    
    [self setExtraCellLineHidden:self.goodsDetailTableView];
//    [self.goodsDetailTableView registerNib:[UINib nibWithNibName:@"GoodsDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"goodsDetailCell"];
//    [self.goodsDetailTableView registerNib:[UINib nibWithNibName:@"EverJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"everJoinCell"];
    //self.goodsDetailTableView.tableHeaderView = [[GoodsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 393)];
    
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
    
    selectView = [[SelectBuyTimes alloc]init];
    selectView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:selectView];
    [selectView.goToPay addTarget:self action:@selector(clickGoToPay:) forControlEvents:(UIControlEventTouchUpInside)];
    selectView.selectBuyTimesTextField.delegate = self;
    [selectView.buyAllTimes addTarget:self action:@selector(clickBuyAllTimes:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self dataGoods];
    [self dataUser];
    
}

- (void)clickBuyAllTimes:(UIButton *)sender{
    [self.goodsModel detailsblock:^(GoodsModel *goodsModel, NSError *error) {
        self.goodsModel = goodsModel;
        selectView.selectBuyTimesTextField.text = [NSString stringWithFormat:@"%@",self.goodsModel.nowCopies];
    }];
    
}

- (void)dataGoods {
    [self.goodsModel detailsblock:^(GoodsModel *goodsModel, NSError *error) {
        self.goodsModel = goodsModel;
        [self.goodsDetailTableView reloadData];
    }];
}

- (void)dataUser{
    [[DataService sharedClient]GET:everJoinUrl parameters:@{} completion:^(id response, NSError *error, NSDictionary *header) {
        self.userArray = [[response objectForKey:@"data"] objectForKey:@"ordersPage"];
        [self.goodsDetailTableView reloadData];
    }];
}

- (void)clickJoinButton:(UIButton *)sender{
    NSLog(@"join pay");

    [UIView animateWithDuration:0.2 animations:^{
        
        // 设置view弹出来的位置
        
        selectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
    
}

- (void)clickGoToPay:(UIButton *)sender{
    //[selectView removeFromSuperview];
    if (selectView.selectBuyTimesTextField.text) {
        selectView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        [selectView.selectBuyTimesTextField resignFirstResponder];
        self.hidesBottomBarWhenPushed = YES;
        GoodsPayViewController *GoodsPayVC = [[GoodsPayViewController alloc]init];
        GoodsPayVC.buyTimes = selectView.selectBuyTimesTextField.text;
        //[self.navigationController showViewController:GoodsPayVC sender:nil];
        [self.navigationController pushViewController:GoodsPayVC animated:YES];
    }else{
        //不允许进行下一步
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.2 animations:^{
        
        // 设置view弹出来的位置
        
        selectView.frame = CGRectMake(0, -216, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.2 animations:^{
        
        // 设置view弹出来的位置
        
        selectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [selectView.selectBuyTimesTextField resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 393;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        GoodsDetailHeaderView *headerView = [[GoodsDetailHeaderView alloc]init];
        [headerView headerView:headerView model:self.goodsModel];
        
        return headerView;
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

//隐藏多余分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    //[tableView setTableHeaderView:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return self.userArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    switch (indexPath.section) {
        case 0:
        {
            [self.goodsDetailTableView registerNib:[UINib nibWithNibName:@"GoodsDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"goodsDetailCell"];
            NSArray *detailArray = [NSArray arrayWithObjects:@"往期揭晓",@"往期晒单", nil];
            GoodsDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailCell"];
            cell.textLabel.text = detailArray[indexPath.row];
            return cell;
        }
            break;
        case 1:
        {
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//            }
//            return cell;
//            NSArray *detailArray = [NSArray arrayWithObjects:@"往期揭晓",@"往期晒单", nil];
            [self.goodsDetailTableView registerNib:[UINib nibWithNibName:@"EverJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"everJoinCell"];
            EverJoinTableViewCell * evercell = [tableView dequeueReusableCellWithIdentifier:@"everJoinCell"];
            evercell.userImage.image = [UIImage imageNamed:@"用户头像"];
            evercell.userName.text = [[self.userArray[indexPath.row] objectForKey:@"users"] objectForKey:@"userName"];
            NSString *province = [[self.userArray[indexPath.row] objectForKey:@"users"] objectForKey:@"province"];
            NSString *city = [[self.userArray[indexPath.row] objectForKey:@"users"] objectForKey:@"city"];
            NSString *Ip = [[self.userArray[indexPath.row] objectForKey:@"users"] objectForKey:@"ip"];
            evercell.userIP.text = [NSString stringWithFormat:@"%@%@ %@",province,city,Ip];
            evercell.joinDate.text = [Tools timestampSwitchTime:[self.userArray[indexPath.row] objectForKey:@"createTime"]];
            evercell.joinTimes.text = [NSString stringWithFormat:@"%@人次",[self.userArray[indexPath.row] objectForKey:@"joinCount"]];
            return evercell;
        }
            break;
            
        default:
            break;
    }
    return nil;

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 75;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"GoodsDetail"bundle:nil];
    UIViewController *showListVC = [board instantiateViewControllerWithIdentifier:@"showEverResultViewController"];
    UIViewController *showResultVC = [board instantiateViewControllerWithIdentifier:@"showEverOrdersViewController"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController showViewController:showListVC sender:nil];
            
        }else{
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController showViewController:showResultVC sender:nil];
        }
    }else{
        
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
