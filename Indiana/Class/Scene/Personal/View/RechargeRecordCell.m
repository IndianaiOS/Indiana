//
//  RechargeRecordCell.m
//  Indiana
//
//  Created by Tagcare on 16/7/6.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "RechargeRecordCell.h"

#import "RechargeRecordModel.h"

@implementation RechargeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)rechargeRecordCell:(RechargeRecordCell *)cell model:(RechargeRecordModel *)model {
    cell.channelLabel.text = model.channel;
    cell.amountLabel.text = [NSString stringWithFormat:@"¥ %d",[model.amount intValue]];
    cell.amountAndPayTimeLabel.text = model.amountAndPayTime;//[Tools timestampSwitchTime:model.amountAndPayTime];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
