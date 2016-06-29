//
//  AppDelegate.m
//  Indiana
//
//  Created by Tagcare on 16/4/14.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import <AFNetworking.h>
#import "TreasureListViewController.h"
#import "Pingpp.h"

@interface AppDelegate ()
{
    NSString *networkInfo;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    TreasureListViewController* root = [[TreasureListViewController alloc] init];
//    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:root];
//    
//    //self.viewController = nav;
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];
    
    [self checkNetwork];
    
    return YES;
}

- (void)checkNetwork{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                networkInfo = @"未知";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                networkInfo = @"没有网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                networkInfo = @"3G|4G";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                networkInfo = @"WiFi";
                break;
            default:
                break;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:networkInfo preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        //[self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
    
    [manger startMonitoring];

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

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}

@end
