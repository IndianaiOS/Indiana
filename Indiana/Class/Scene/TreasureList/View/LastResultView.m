//
//  LastResultView.m
//  Indiana
//
//  Created by Tagcare on 16/7/4.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "LastResultView.h"
#import "GoodsModel.h"


@implementation LastResultView

- (void)lastView:(LastResultView *)lastView model:(GoodsModel *)model{
    NSLog(@"model.indexImages = %@ model.goodsName = %@",model.indexImages,model.goodsName);
    [lastView.lastResultImageView sd_setImageWithURL:[self imageUrl:model.indexImages] placeholderImage:nil];
    lastView.lastResultNameLabel.text = model.goodsName;
}

- (NSURL *)imageUrl:(NSString *)imageStr {
     NSString * imageUrl = [NSString stringWithFormat:@"%@%@",SERVER_URL,imageStr];
     return [NSURL URLWithString:imageUrl];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
