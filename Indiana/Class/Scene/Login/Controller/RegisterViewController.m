//
//  RegisterViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/22.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterFooterView.h"
#import "PhoneCell.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.tabelView registerClass:[PhoneCell class]  forCellReuseIdentifier:@"phoneCell"];
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"verifyCodeCell"];
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"passwordCell"];
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"password2Cell"];

    // Do any additional setup after loading the view.
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
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"RegisterFooterView" owner:self options:nil];
    RegisterFooterView * footView = [nib objectAtIndex:0];
    return footView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{
            PhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phoneCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor redColor];
            return cell;
        }
            break;
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"verifyCodeCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"passwordCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 3:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"password2Cell" forIndexPath:indexPath];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
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
