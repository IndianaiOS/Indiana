//
//  ViewController.h
//  Indiana
//
//  Created by Tagcare on 16/4/14.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "UIScrollView+EmptyDataSet.h"
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, strong)UITableView * baseTableView;

/**
 *  下拉刷新、上拉加载更过
 */
- (void)setupRefresh;

@end

