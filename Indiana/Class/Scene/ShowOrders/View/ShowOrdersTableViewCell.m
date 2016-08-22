//
//  ShowOrdersTableViewCell.m
//  Indiana
//
//  Created by Tagcare on 16/8/16.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "ShowOrdersTableViewCell.h"

@implementation ShowOrdersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellHeight:(NSString *)str{
    self.personDetailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.personDetailLabel.preferredMaxLayoutWidth = self.personDetailLabel.frame.size.width;
    self.personDetailLabel.text = str;
}

@end
