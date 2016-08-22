//
//  ShowEverOrdersViewController.m
//  Indiana
//
//  Created by Tagcare on 16/8/16.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "ShowEverOrdersViewController.h"

@interface ShowEverOrdersViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ShowEverOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ordersTableView.delegate = self;
    self.ordersTableView.dataSource = self;
    self.ordersTableView.separatorStyle = YES;
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(showWinning:)];
    self.navigationItem.rightBarButtonItem = addItem;
    
    [self.ordersTableView registerNib:[UINib nibWithNibName:@"ShowOrdersTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"showOrdersTableViewCell"];
    
}

- (void)showWinning:(id)sender{
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *aString =  @"随着先来一张用MMD渲染出来的图引狼。本教程目的在于给入门级MMD玩家介绍下最基本的MME使用方法，并提供一些常用MME的资源下载，以便于新入门玩家能够迅速制作出高质量的MMD渲染效果。大触手和老鸟请自动无视，如有不足之处当然还是请大触和老鸟多多指点，谢谢。";
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    //cell.personDetailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(self.view.frame.size.width-87,0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
//    CGSize size =  [aString sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(cell.personDetailLabel.frame.size.width, MAXFLOAT) lineBreakMode:];;
    if (rect.size.height<20) {
        return rect.size.height + (self.view.frame.size.width-87-20)/3 + 152;
    }
    return rect.size.height + (self.view.frame.size.width-87-20)/3 + 112;
//    return 268;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowOrdersTableViewCell *cell = [self.ordersTableView dequeueReusableCellWithIdentifier:@"showOrdersTableViewCell"];
    cell.personDetailLabel.text = @"随着先来一张用MMD渲染出来的图引狼。本教程目的在于给入门级MMD玩家介绍下最基本的MME使用方法，并提供一些常用MME的资源下载，以便于新入门玩家能够迅速制作出高质量的MMD渲染效果。大触手和老鸟请自动无视，如有不足之处当然还是请大触和老鸟多多指点，谢谢。";
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
