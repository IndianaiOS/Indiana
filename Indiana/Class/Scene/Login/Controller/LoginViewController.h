//
//  LoginViewController.h
//  Indiana
//
//  Created by Tagcare on 16/6/22.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)dismissViewformLogin;
- (void)showRegisterView;

@end

@interface LoginViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic)id<LoginViewControllerDelegate> delegate;
@end
