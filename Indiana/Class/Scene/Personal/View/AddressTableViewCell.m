//
//  AddressTableViewCell.m
//  Indiana
//
//  Created by Tagcare on 16/8/27.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (IBAction)textFieldDidEndOnExit:(id)sender {
    [self.detailText resignFirstResponder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
