//
//  PayView.h
//  Indiana
//
//  Created by Tagcare on 16/6/28.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayView : UIView
@property (weak, nonatomic) IBOutlet UIButton *selectPayChannelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmPayButton;
@property (weak, nonatomic) IBOutlet UILabel *buyTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyTimesCountLabel;

@end
