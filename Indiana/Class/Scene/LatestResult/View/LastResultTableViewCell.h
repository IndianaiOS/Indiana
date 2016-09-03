//
//  LastResultTableViewCell.h
//  Indiana
//
//  Created by Tagcare on 16/8/19.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@interface LastResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateNumber;
@property (weak, nonatomic) IBOutlet UILabel *joinTimes;
@property (weak, nonatomic) IBOutlet MZTimerLabel *countDown;

@end
