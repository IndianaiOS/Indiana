//
//  AppDelegate.m
//  Indiana
//
//  Created by Tagcare on 16/4/14.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "NewViewController.h"
#import "ListViewController.h"
#import "MyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
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
    
    UITabBarController *tabBC = [[UITabBarController alloc]init];
    tabBC.viewControllers = @[homeNC,newNC,listNC,myNC];
    
    self.window.rootViewController = tabBC;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
