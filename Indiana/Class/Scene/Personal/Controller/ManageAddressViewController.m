//
//  ManageAddressViewController.m
//  Indiana
//
//  Created by Tagcare on 16/8/26.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "ManageAddressViewController.h"
#import "AddAddressViewController.h"
#import "ManageTableViewCell.h"

static NSString *manageUrl = @"http://192.168.0.123:8888/api/v1/address/userAddresses?push_token=123456789";

@interface ManageAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *addressArray;

@end

@implementation ManageAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"管理收货地址", nil);
    self.navigationController.navigationBarHidden = NO;
    
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    self.addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self data];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickToAddAddress:)];
    [self.addView addGestureRecognizer:tap];
    
    [self.addressTableView registerNib:[UINib nibWithNibName:@"ManageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"manageTableViewCell"];
}

- (void)data{
    [[DataService sharedClient] GET:manageUrl parameters:@{} completion:^(id response, NSError *error, NSDictionary *header) {
        if (response) {
            NSLog(@"success");
            self.addressArray = [[response objectForKey:@"data"] objectForKey:@"usersAddressList"];
            [self.addressTableView reloadData];
            if (!self.addressArray) {
                UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"空状态"]];
                UIImageView *vi = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"空状态"]];
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, (SCREENHEIGHT-vi.frame.size.height)/2-30+vi.frame.size.height, SCREENWIDTH, 30)];
                label.text = @"您还没有收货地址哦！";
                label.textAlignment = NSTextAlignmentCenter;
                view.frame = CGRectMake((SCREENWIDTH-vi.frame.size.width)/2, (SCREENHEIGHT-vi.frame.size.height)/2-30, vi.frame.size.width, vi.frame.size.height);
                [self.view addSubview:label];
                [self.view addSubview:view];
            }
        }
    }];
}

- (void)clickToAddAddress:(id)sender{
    AddAddressViewController *addVC = [[AddAddressViewController alloc]init];
    [self.navigationController showViewController:addVC sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"manageTableViewCell"];
    [cell manageCell:cell model:self.addressArray[indexPath.row]];
    return cell;
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
