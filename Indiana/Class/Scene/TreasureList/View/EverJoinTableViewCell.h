//
//  EverJoinTableViewCell.h
//  Indiana
//
//  Created by Tagcare on 16/8/12.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EverJoinTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userIP;
@property (weak, nonatomic) IBOutlet UILabel *joinDate;
@property (weak, nonatomic) IBOutlet UILabel *joinTimes;

@end
