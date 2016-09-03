//
//  ManageTableViewCell.h
//  Indiana
//
//  Created by Tagcare on 16/8/31.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *deaultButton;
@property (weak, nonatomic) IBOutlet UIButton *editorButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (void)manageCell:(ManageTableViewCell *)cell model:(NSDictionary *)model;

@end
