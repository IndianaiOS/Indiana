//
//  GoodsCollectionViewCell.h
//  Indiana
//
//  Created by Tagcare on 16/6/21.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsModel;

@interface GoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsListImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsListNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsListProgressLabel;
@property (weak, nonatomic) IBOutlet UIButton *addGoodsToListButton;
@property (weak, nonatomic) IBOutlet UIProgressView *goodsListProgressView;


- (void)cell:(GoodsCollectionViewCell *)cell model:(GoodsModel *)model;

@end
