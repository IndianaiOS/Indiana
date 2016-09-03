//
//  ManageTableViewCell.m
//  Indiana
//
//  Created by Tagcare on 16/8/31.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "ManageTableViewCell.h"

@implementation ManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)manageCell:(ManageTableViewCell *)cell model:(NSDictionary *)model{
    cell.nameLabel.text = [model objectForKey:@"userName"];
    cell.telLabel.text = [model objectForKey:@"tel"];
    cell.detailLabel.text = [model objectForKey:@"detailed"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
