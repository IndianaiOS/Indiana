//
//  TreasureListViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "TreasureListViewController.h"
#import "GoodsCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "GoodsDetailViewController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "Pingpp.h"
#import "DataService.h"
#import "GoodsModel.h"

static NSString *const collectionCellID = @"goodsListCell";
static NSString *const headerCollectionReusableViewID = @"goodsHeaderView";

@interface TreasureListViewController (){
    UIButton *hotBtn;
    UIButton *fastBtn;
    UIButton *newBtn;
    UIButton *higtBtn;
    UIButton *lowBtn;
    UIView *redView;
    UICollectionReusableView *reusableview;
    NSDictionary *dataDic;
}

@property (weak, nonatomic) IBOutlet UICollectionView *goodsListCollection;
@property (strong, nonatomic) NSArray *goodsListArray;
@property (strong, nonatomic) NSMutableDictionary *parameters;
@end

@implementation TreasureListViewController

- (void)viewWillDisappear:(BOOL)animated {
    [self setHidesBottomBarWhenPushed:NO];
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.goodsListCollection.delegate = self;
    self.goodsListCollection.dataSource =self;
    
    [self.goodsListCollection registerNib:[UINib nibWithNibName:@"GoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCellID];
    
    [self.goodsListCollection registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"goodsHeaderView"];
    self.parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"label":@"1",
                                 @"state":@"1",
                                 @"pageNumber":@"1",
                                 @"pageSize":@"10"}];
    [self data:self.parameters];
    
}

- (void)parametersKey:(NSString *)key value:(NSString *)value {
    [self.parameters removeObjectForKey:key];
    [self.parameters setObject:value forKey:key];
}

- (void)data:(NSDictionary *)parameters {
    

    [GoodsModel GETUrl:@""
            parameters:parameters
                 block:^(GoodsListModel *goodsList, NSError *error) {
                     self.goodsListArray = goodsList.schedulePage;
                     [self.goodsListCollection reloadData];
            }];
    

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/2-0.5, (self.view.frame.size.width/2-0.5)*220/187);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsListArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCollectionViewCell *cell = [self.goodsListCollection dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];

    GoodsModel * goods = self.goodsListArray[indexPath.row];
    [cell cell:cell model:goods];
    
    
    return cell;
};

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionReusableView *reusableview = nil;
    if(!reusableview){
        if (kind == UICollectionElementKindSectionHeader){
            
            HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectionReusableViewID forIndexPath:indexPath];
            int x = self.view.frame.size.width/5;

            NSArray *arr = @[@"最新",@"最快",@"最热",@"高价",@"低价"];
            for (int i= 0; i<5; i++) {
                UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
                btn.tag = 100+i;
                btn.frame = CGRectMake(x*i, 0, x, 40);
                [btn setTitle:arr[i] forState:(UIControlStateNormal)];
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
                [headerView.goodsTagView addSubview:btn];
            }

            redView = [[UIView alloc]initWithFrame:(CGRectMake(0, 36, x, 4))];
            redView.backgroundColor = [UIColor redColor];
            [headerView.goodsTagView addSubview:redView];

            
            reusableview = headerView;
            
        }
    }
    return reusableview;
}

//获取ip地址
- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
- (void)clickBtn:(UIButton *)sender{
    
    //动画
    int x = self.view.frame.size.width/5;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame = CGRectMake((sender.tag-100)*x, 36, x, 4);
    [redView setFrame:frame];
    [UIView commitAnimations];
    if (sender.tag == 100) {
        [self parametersKey:@"label" value:@"3"];
        [self data:self.parameters];
    }else if (sender.tag == 101){
        [self parametersKey:@"label" value:@"2"];
        [self data:self.parameters];
    }else if (sender.tag == 102){
        [self parametersKey:@"label" value:@"1"];
        [self data:self.parameters];
    }else if (sender.tag == 103){
        [self parametersKey:@"label" value:@"4"];
        [self data:self.parameters];
    }else if (sender.tag == 104){
        [self parametersKey:@"label" value:@"5"];
        [self data:self.parameters];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"GoodsDetail" bundle:[NSBundle mainBundle]];
    GoodsDetailViewController * goodsDetailVC = (GoodsDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"goodsDetailViewController"];
    
    goodsDetailVC.goodsModel = self.goodsListArray[indexPath.row];
    [self.navigationController showViewController:goodsDetailVC sender:nil];
    
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(375, 426);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
