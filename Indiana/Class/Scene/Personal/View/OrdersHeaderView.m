//
//  OrdersHeaderView.m
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrdersHeaderView.h"

@implementation OrdersHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)winningButtonAction:(id)sender {

    [self redViewAnimation:1];
    [self.winningBtn setTitleColor:COLOR_RED forState:UIControlStateNormal];
    [self.goingBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    [self.announceBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(winningButton)]) {
        
        [self.delegate winningButton];
    }

}

- (IBAction)goingButtonAction:(id)sender {
    [self redViewAnimation:2];
    [self.goingBtn setTitleColor:COLOR_RED forState:UIControlStateNormal];
    [self.winningBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    [self.announceBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(goingButton)]) {
        
        [self.delegate goingButton];
    }
}

- (IBAction)announceButtonAction:(id)sender {
    [self redViewAnimation:3];
    [self.announceBtn setTitleColor:COLOR_RED forState:UIControlStateNormal];
    [self.winningBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    [self.goingBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(announceButton)]) {
        
        [self.delegate announceButton];
    }
}

-(void)redViewAnimation:(int)a {
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame = CGRectMake((a-1)*SCREENWIDTH/3, 42, SCREENWIDTH/3, 3);
    [self.redView setFrame:frame];
    [UIView commitAnimations];
}
@end
