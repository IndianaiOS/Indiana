//
//  RegisterViewController.h
//  Indiana
//
//  Created by Tagcare on 16/6/22.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewControllerDelegate <NSObject>

- (void)dismissViewformRegister;

@end
@interface RegisterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic)id<RegisterViewControllerDelegate> delegate;


@end
