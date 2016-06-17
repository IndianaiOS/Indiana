//
//  TabBarController.m
//  Indiana
//
//  Created by Tagcare on 16/4/15.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "NewViewController.h"
#import "ListViewController.h"
#import "MyViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController * homeNC = [[UINavigationController alloc]initWithRootViewController:homeVC];
    homeNC.tabBarItem.title = @"零钱夺宝";
    
    NewViewController *newVC = [[NewViewController alloc]init];
    UINavigationController * newNC = [[UINavigationController alloc]initWithRootViewController:newVC];
    newNC.tabBarItem.title = @"最新揭晓";
    
    ListViewController *listVC = [[ListViewController alloc]init];
    UINavigationController * listNC = [[UINavigationController alloc]initWithRootViewController:listVC];
    listNC.tabBarItem.title = @"清单";
    
    MyViewController *myVC = [[MyViewController alloc]init];
    UINavigationController * myNC = [[UINavigationController alloc]initWithRootViewController:myVC];
    myNC.tabBarItem.title = @"我";
    
    self.viewControllers = @[homeNC,newNC,listNC,myNC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
