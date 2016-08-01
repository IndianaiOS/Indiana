//
//  PersonalHeaderView.h
//  Indiana
//
//  Created by Tagcare on 16/7/4.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalHeaderViewDelegate <NSObject>

- (void)changeUserIconTap;

@end

@interface PersonalHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *balancesLabel;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (assign, nonatomic)id<PersonalHeaderViewDelegate> delegate;


- (void)personalheaderView:(PersonalHeaderView *)headerView model:(UserInfoModel *)model;

@end
