//
//  LocaldData.m
//  Indiana
//
//  Created by Tagcare on 16/7/2.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "LocaldData.h"
#import "UserInfoModel.h"

#define USER_INFO @"userInfo"

@implementation LocaldData

//保存用户信息
+ (void)saveListData:(UserInfoModel *)infoModel {
    NSString *filePath = [self savePathName:USER_INFO];//获取文件路径
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:infoModel];//原数据转化为NSData类型
    NSMutableArray *listArray =
    [[NSMutableArray alloc] initWithObjects:data, nil];//把data放在数组
    [listArray writeToFile:filePath atomically:YES];//把数组写入文件
}

//获取用户信息
+ (UserInfoModel *)achieveListDataType {
    NSString *filePath = [self savePathName:USER_INFO];//获取文件路径
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];//把文件取出放入数字
    UserInfoModel *infoModel =
    [NSKeyedUnarchiver unarchiveObjectWithData:dataArray[0]];//把数组中的data转化为RootListModel类型的数据
    return infoModel;
}

//返回的路径
+ (NSString *)savePathName:(NSString *)name {
    //获取沙盒路径
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
    NSString *pathStr = [pathArray objectAtIndex:0];
    //拼接路径和名字得到文件路径
    NSString *filePath = [pathStr stringByAppendingPathComponent:name];
    return filePath;
}

@end
