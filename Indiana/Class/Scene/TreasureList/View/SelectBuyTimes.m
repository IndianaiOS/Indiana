//
//  SelectBuyTimes.m
//  Indiana
//
//  Created by Tagcare on 16/6/30.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "SelectBuyTimes.h"

@implementation SelectBuyTimes

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // add subviews
        NSArray *view = [[NSBundle mainBundle] loadNibNamed:@"PayView" owner:self options:nil];
        self = [view objectAtIndex:0];
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
