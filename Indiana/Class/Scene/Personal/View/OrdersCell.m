//
//  OrdersCell.m
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrdersCell.h"
#import "OrdersModel.h"

@implementation OrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)ordersCell:(OrdersCell *)cell model:(OrdersModel *)model {
//    cell.goodsImage
    cell.goodsNameLabel.text = model.goodsName;
    cell.scheduleNoLabel.text = [NSString stringWithFormat:NSLocalizedString(@"期号：%@", nil),model.scheduleNo];
    cell.joinCountLabel.text = [NSString stringWithFormat:NSLocalizedString(@"本期参与：%@人次", nil),model.joinCount];
    [cell.winnerBtn setTitle:model.userName forState:UIControlStateNormal];
    
}

- (IBAction)buyAgainButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buyAgainButton)]) {
        
        [self.delegate buyAgainButton];
    }
}

- (IBAction)viewNumberButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(viewNumberButton)]) {
        
        [self.delegate viewNumberButton];
    }
}

- (IBAction)winnerButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(winnerButton)]) {
        
        [self.delegate winnerButton];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
