//
//  RechargeRecordCell.h
//  Indiana
//
//  Created by Tagcare on 16/7/6.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RechargeRecordModel;

@interface RechargeRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *channelLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountAndPayTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

- (void)rechargeRecordCell:(RechargeRecordCell *)cell model:(RechargeRecordModel *)model;

@end
