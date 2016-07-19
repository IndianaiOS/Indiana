//
//  GoodsDetailHeaderView.m
//  Indiana
//
//  Created by Tagcare on 16/6/27.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsDetailHeaderView.h"
#import "GoodsModel.h"

#import "UIImageView+WebCache.h"

@implementation GoodsDetailHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // add subviews
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GoodsDetailHeaderView" owner:self options:nil];
        //得到第一个UIView
        self = [nib objectAtIndex:0];
    }
    return self;
}

- (void)headerView:(GoodsDetailHeaderView *)headerView model:(GoodsModel *)goods {
    self.goodsDetailNameLabel.text = goods.goodsName;
    self.goodsDetailNumberLabel.text = [NSString stringWithFormat:@"期号：%@",goods.scheduleNo];
    self.goodsDetailAllNumber.text = [NSString stringWithFormat:@"总需：%@",goods.copies];
    self.goodsDetailSurplusNumber.text = [NSString stringWithFormat:@"剩余：%@",goods.nowCopies];
    [self.goodsDetailProgressView setProgress:[goods.nowCopies floatValue]/[goods.copies floatValue] animated:YES];
    [self.goodsDetailImageView sd_setImageWithURL:[self imageUrl:goods.infoImages] placeholderImage:nil];
}

- (NSURL *)imageUrl:(NSString *)imageStr {
    NSArray *imageArray = [imageStr componentsSeparatedByString:@","];
    NSString * imageUrl = [NSString stringWithFormat:@"http://123.56.181.65:8888%@",imageArray[0]];
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
