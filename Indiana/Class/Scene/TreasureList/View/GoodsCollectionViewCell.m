//
//  GoodsCollectionViewCell.m
//  Indiana
//
//  Created by Tagcare on 16/6/21.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsCollectionViewCell.h"
#import "GoodsModel.h"

#import "UIImageView+WebCache.h"

@implementation GoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cell:(GoodsCollectionViewCell *)cell model:(GoodsModel *)model {
    cell.goodsListNameLabel.text = model.goodsName;
    [cell.goodsListImageView sd_setImageWithURL:[self imageUrl:model.indexImages] placeholderImage:nil];
    cell.goodsListProgressLabel.text = [NSString stringWithFormat:@"%@",[self goodsListProgress:model]];
    [cell.goodsListProgressView setProgress:[model.nowCopies floatValue]/[model.copies floatValue] animated:YES];
}

- (NSString *)goodsListProgress:(GoodsModel *)model {
    float a = [model.nowCopies floatValue]/[model.copies floatValue]*100;
    NSString * str = [NSString stringWithFormat:@"%.f",a];
    return [str stringByAppendingString:@"%"];
}

- (NSURL *)imageUrl:(NSString *)imageStr {
    NSString * imageUrl = [NSString stringWithFormat:@"http://123.56.181.65:8888%@",imageStr];
    return [NSURL URLWithString:imageUrl];
}


@end
