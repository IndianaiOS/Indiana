//
//  GoodsDetailHeaderView.h
//  Indiana
//
//  Created by Tagcare on 16/6/27.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;

@interface GoodsDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *goodsDetailImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailAllNumber;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailSurplusNumber;
@property (weak, nonatomic) IBOutlet UIProgressView *goodsDetailProgressView;

- (void)headerView:(GoodsDetailHeaderView *)headerView model:(GoodsModel *)goods;
@end
