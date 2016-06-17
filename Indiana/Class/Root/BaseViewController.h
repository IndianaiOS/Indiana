//
//  BaseViewController.h
//  Indiana
//
//  Created by Tagcare on 16/4/15.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface BaseViewController : UIViewController<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic, strong)UITableView * baseTableView;

/**
 *  下拉刷新、上拉加载更过
 */
- (void)setupRefresh;

/**
 *  空白页
 */
- (void)setupEmptyView;

/**
 *  返回按钮
 */
- (void)returnButton;

@end
