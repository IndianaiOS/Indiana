//
//  LoginModel.m
//  Indiana
//
//  Created by Tagcare on 16/6/28.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "LoginModel.h"
#import "UMSocial.h"

#import "UserInfoModel.h"

@implementation LoginModel

- (void)QQLogin:(UIViewController *)viewController {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
//            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSDictionary * thirdPlatformUserProfile = response.thirdPlatformUserProfile;
            
            UserInfoModel *userInfo = [[UserInfoModel alloc] init];
            userInfo.uid = snsAccount.usid;
            userInfo.nickname = snsAccount.userName;
            userInfo.avatar = snsAccount.iconURL;
            userInfo.logintype = LOGIN_TYPE_QQ;
            userInfo.gender = thirdPlatformUserProfile[@"gender"];
            
            [userInfo loginBlock:^(UserInfoModel *userInfoModel, NSError *error) {
                //持久化
                //保存数据
                [LocaldData saveListData:userInfoModel];
            }];
        }});
}

- (void)weiXinLogin:(UIViewController *)viewController {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
//            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            
            UserInfoModel *userInfo = [[UserInfoModel alloc] init];
            userInfo.uid = snsAccount.usid;
            userInfo.nickname = snsAccount.userName;
            userInfo.avatar = snsAccount.iconURL;
            userInfo.logintype = LOGIN_TYPE_QQ;
            userInfo.gender = @"";
            
            [userInfo loginBlock:^(UserInfoModel *userInfoModel, NSError *error) {
                //持久化
                //保存数据
                [LocaldData saveListData:userInfoModel];
            }];
            
        }
        
    });
}


@end
