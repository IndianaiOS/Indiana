//
//  HeaderCollectionReusableView.h
//  Indiana
//
//  Created by Tagcare on 16/6/23.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LastResultView.h"

@protocol HeaderCollectionReusableViewDelegate <NSObject>

- (void)touchBtnTag:(NSInteger)tag;

@end
@interface HeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *goodsTagView;
@property (weak, nonatomic) IBOutlet UIView *lastResultView;
@property (weak, nonatomic) IBOutlet LastResultView *firstLastResultView;
@property (weak, nonatomic) IBOutlet LastResultView *secondLastResultView;
@property (weak, nonatomic) IBOutlet LastResultView *thirdLastResultView;
@property (strong, nonatomic) UIButton *tagBtn;
@property (strong, nonatomic) UIView *redView;
@property (assign, nonatomic) id<HeaderCollectionReusableViewDelegate>delegate;

- (void)headerView:(HeaderCollectionReusableView *)headerView model:(NSArray *)modellist;


@end
