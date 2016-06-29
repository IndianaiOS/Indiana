//
//  VerifyCodeCell.h
//  Indiana
//
//  Created by Tagcare on 16/6/24.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeButton;

@end
