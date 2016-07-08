//
//  UserInfoModel.h
//  Indiana
//
//  Created by Tagcare on 16/6/29.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *uid;//uid
@property (nonatomic, strong)NSString *nickname;//昵称
@property (nonatomic, strong)NSString *gender;//性别
@property (nonatomic, strong)NSString *avatar;//头像地址
@property (nonatomic, strong)NSString *logintype;//登录类型1 qq 2 wx 3 phone
@property (nonatomic, strong)NSString *resolution;//手机分辨率
@property (nonatomic, strong)NSString *os;//操作系统
@property (nonatomic, strong)NSString *appversion;//app版本   v0.0.1
@property (nonatomic, strong)NSString *deviceid;//设备id  (hash)
@property (nonatomic, strong)NSString *phone;//手机号
@property (nonatomic, strong)NSString *password;//密码
@property (nonatomic, strong)NSString *push_token;
@property (nonatomic, strong)NSString *coin;//夺宝币
@property (nonatomic, strong)NSString *captcha;//验证码

//登录
- (NSURLSessionDataTask *)loginBlock:(void (^)(UserInfoModel *userInfoModel,
                                                 NSError *error))completion;
//注册
- (NSURLSessionDataTask *)phoneRegisterBlock:(void (^)(UserInfoModel *userInfoModel,
                                                       NSError *error))completion;
//验证码
- (NSURLSessionDataTask *)phoneRegisterCAPTCHABlock:(void (^)(NSString * code,
                                                              NSError *error))completion;
@end
