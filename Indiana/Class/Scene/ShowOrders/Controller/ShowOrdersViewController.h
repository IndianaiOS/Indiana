//
//  ShowOrdersViewController.h
//  Indiana
//
//  Created by Tagcare on 16/6/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ShowOrdersTableViewCell.h"

@interface ShowOrdersViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *ordersTableView;

@end
