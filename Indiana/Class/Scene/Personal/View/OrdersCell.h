//
//  OrdersCell.h
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrdersModel;

@protocol OrdersCellDelegate <NSObject>

- (void)buyAgainButton;
- (void)viewNumberButton:(UIButton *)sender;
- (void)winnerButton;

@end

@interface OrdersCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *scheduleNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *joinCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *winnerBtn;
@property (weak, nonatomic) IBOutlet UIButton *viewNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyAgainBtn;

@property (assign, nonatomic)id<OrdersCellDelegate>delegate;

- (void)ordersCell:(OrdersCell *)cell model:(OrdersModel *)model;


@end
