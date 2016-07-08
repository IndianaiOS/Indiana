//
//  PersonalHeaderView.m
//  Indiana
//
//  Created by Tagcare on 16/7/4.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "PersonalHeaderView.h"

@implementation PersonalHeaderView

- (void)personalheaderView:(PersonalHeaderView *)headerView model:(UserInfoModel *)model {
    if (model.push_token == nil) {
        self.nickNameLabel.hidden = YES;
        self.balancesLabel.hidden = YES;
        self.rechargeBtn.hidden = YES;
        self.loginBtn.hidden = NO;
    }else {
        self.loginBtn.hidden = YES;
        self.nickNameLabel.hidden = NO;
        self.balancesLabel.hidden = NO;
        self.rechargeBtn.hidden = NO;
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
        self.nickNameLabel.text = model.nickname;
        self.balancesLabel.text = [NSString stringWithFormat:@"余额：%@",model.coin];
    }

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
