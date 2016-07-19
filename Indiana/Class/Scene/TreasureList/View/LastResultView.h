//
//  LastResultView.h
//  Indiana
//
//  Created by Tagcare on 16/7/4.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;

@interface LastResultView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *lastResultImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastResultNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastResultTimeLabel;

- (void)lastView:(LastResultView *)lastView model:(GoodsModel *)model;

@end
