//
//  GoodsDetailHeaderView.m
//  Indiana
//
//  Created by Tagcare on 16/6/27.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsDetailHeaderView.h"

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
