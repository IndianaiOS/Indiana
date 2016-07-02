//
//  LocaldData.h
//  Indiana
//
//  Created by Tagcare on 16/7/2.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoModel;

@interface LocaldData : NSObject

//保存用户信息
+ (void)saveListData:(UserInfoModel *)infoModel;
//获取用户信息
+ (UserInfoModel *)achieveListDataType;

@end
