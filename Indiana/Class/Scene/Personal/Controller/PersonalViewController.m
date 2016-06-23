//
//  PersonalViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalCell.h"

@interface PersonalViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.tabelView registerNib:[UINib nibWithNibName:@"PersonalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"personalCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 8;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell"];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = NSLocalizedString(@"积分", nil);
                break;
            case 1:
                cell.titleLabel.text = NSLocalizedString(@"优惠券", nil);
                break;
            case 2:
                cell.titleLabel.text = NSLocalizedString(@"管理收货地址", nil);
                break;
            default:
                break;
        }

    }else {
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = NSLocalizedString(@"订单记录", nil);
                break;
            case 1:
                cell.titleLabel.text = NSLocalizedString(@"充值记录", nil);
                break;
            case 2:
                cell.titleLabel.text = NSLocalizedString(@"绑定银行卡", nil);
                break;
            default:
                break;
        }
    }
    
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
