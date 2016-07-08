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
        NSArray *view = [[NSBundle mainBundle] loadNibNamed:@"SelectBuytimes" owner:self options:nil];
        self = [view objectAtIndex:0];
        self.selectBuyTimesTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (IBAction)clickMinusButton:(id)sender {
    if ([self.selectBuyTimesTextField.text isEqualToString:@"1"]) {
        
    }else{
        NSString *times = [NSString stringWithFormat:@"%d",[self.selectBuyTimesTextField.text intValue]-1];
        self.selectBuyTimesTextField.text = times;
    }
    
}
- (IBAction)clickAddButton:(id)sender {
    if ([self.selectBuyTimesTextField.text isEqualToString:@""]) {
        NSString *times = @"1";
        self.selectBuyTimesTextField.text = times;
    }else{
        NSString *times = [NSString stringWithFormat:@"%d",[self.selectBuyTimesTextField.text intValue]+1];
        self.selectBuyTimesTextField.text = times;
    }
}
- (IBAction)clickButton10:(id)sender {
    self.selectBuyTimesTextField.text = @"10";
}
- (IBAction)clickButton50:(id)sender {
    self.selectBuyTimesTextField.text = @"50";
}
- (IBAction)clickButton100:(id)sender {
    self.selectBuyTimesTextField.text = @"100";
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
