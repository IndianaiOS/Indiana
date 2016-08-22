//
//  ShowOrdersTableViewCell.h
//  Indiana
//
//  Created by Tagcare on 16/8/16.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowOrdersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *personHeadImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personDetailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;

- (void)cellHeight:(NSString *)str;

@end
