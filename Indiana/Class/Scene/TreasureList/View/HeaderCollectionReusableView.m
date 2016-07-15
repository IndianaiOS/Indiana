//
//  HeaderCollectionReusableView.m
//  Indiana
//
//  Created by Tagcare on 16/6/23.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupSubviews];
    
}

- (void)headerView:(HeaderCollectionReusableView *)headerView model:(NSArray *)modellist {
//    [self.firstLastResultView lastView:self.firstLastResultView model:modellist[0]];
//    [self.secondLastResultView lastView:self.secondLastResultView model:modellist[1]];
//    [self.thirdLastResultView lastView:self.thirdLastResultView model:modellist[2]];

    
}

- (void)setupSubviews {
    NSArray *arr = @[@"最新",@"最快",@"最热",@"高价",@"低价"];
    for (int i= 0; i<5; i++) {
        self.tagBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.tagBtn.tag = 100+i;
        self.tagBtn.frame = CGRectMake(SCREENWIDTH/5*i, 0, SCREENWIDTH/5, 40);
        [self.tagBtn setTitle:arr[i] forState:(UIControlStateNormal)];
        [self.tagBtn addTarget:self action:@selector(tagBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.goodsTagView addSubview:self.tagBtn];
    }
    
    self.redView = [[UIView alloc]initWithFrame:(CGRectMake(0, 36, SCREENWIDTH/5, 4))];
    self.redView.backgroundColor = [UIColor redColor];
    [self.goodsTagView addSubview:self.redView];
    
    

}

- (void)tagBtnAction:(UIButton *)btn {
    
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame = CGRectMake((btn.tag-100)*SCREENWIDTH/5, 36, SCREENWIDTH/5, 4);
    [self.redView setFrame:frame];
    [UIView commitAnimations];
    
    if (_delegate && [_delegate respondsToSelector:@selector(touchBtnTag:)]) {
        [_delegate touchBtnTag:btn.tag];
    }
}


@end
