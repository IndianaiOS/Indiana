//
//  OrdersHeaderView.h
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OrdersHeaderViewDelegate <NSObject>

- (void)winningButton;
- (void)goingButton;
- (void)announceButton;

@end

@interface OrdersHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) IBOutlet UIButton *winningBtn;
@property (strong, nonatomic) IBOutlet UIButton *goingBtn;
@property (strong, nonatomic) IBOutlet UIButton *announceBtn;
@property (strong, nonatomic) IBOutlet UIView *redView;

@property (assign, nonatomic)id<OrdersHeaderViewDelegate> delegate;

@end
