//
//  UserInfoModel.m
//  Indiana
//
//  Created by Tagcare on 16/6/29.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "UserInfoModel.h"

static NSString *const loginUrl = @"login";
static NSString *const phoneRegisterCAPTCHAUrl = @"phoneRegisterCAPTCHA";
static NSString *const phoneRegisterUrl = @"phoneRegister";

@implementation UserInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

- (NSURLSessionDataTask *)loginBlock:(void (^)(UserInfoModel *userInfoModel,
                                               NSError *error))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryObject]];
    [parameters setObject:@"uid" forKey:self.uid];
    [parameters setObject:@"nickname" forKey:self.nickname];
    [parameters setObject:@"gender" forKey:self.gender];
    [parameters setObject:@"avatar" forKey:self.avatar];
    [parameters setObject:@"logintype" forKey:self.logintype];

    return [[DataService sharedClient]
            POST:[self url:loginUrl]
            parameters:parameters
            completion:^(id response, NSError *error) {
                UserInfoModel *userInfo = [MTLJSONAdapter modelOfClass:[UserInfoModel class]
                                            fromJSONDictionary:response
                                                         error:&error];
                completion(userInfo, error);
            }];
}

- (NSURLSessionDataTask *)phoneRegisterBlock:(void (^)(UserInfoModel *userInfoModel,
                                               NSError *error))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryObject]];
    [parameters setObject:@"captcha" forKey:self.captcha];
    
    return [[DataService sharedClient]
            POST:[self url:phoneRegisterUrl]
            parameters:parameters
            completion:^(id response, NSError *error) {
                UserInfoModel *userInfo = [MTLJSONAdapter modelOfClass:[UserInfoModel class]
                                                    fromJSONDictionary:response
                                                                 error:&error];
                completion(userInfo, error);
            }];
}

- (NSURLSessionDataTask *)phoneRegisterCAPTCHABlock:(void (^)(NSString * code,
                                                              NSError *error))completion; {
    NSDictionary *parameters = @{@"phone":self.phone};
    return [[DataService sharedClient]
            POST:[self url:phoneRegisterCAPTCHAUrl]
            parameters:parameters
            completion:^(id response, NSError *error) {
                NSDictionary * data = response[@"data"];
                NSString * code = data[@"code"];
                completion(code, error);

            }];
}

- (NSString *)url:(NSString *)str {
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_URL,str];
    return url;
}

-(NSMutableDictionary *)dictionaryObject{
    
    NSMutableDictionary * userInfoDic = [[NSMutableDictionary alloc]init];
    
    [userInfoDic setObject:self.resolution forKey:@"resolution"];
    [userInfoDic setObject:self.os forKey:@"os"];
    [userInfoDic setObject:self.appversion forKey:@"appversion"];
    [userInfoDic setObject:self.deviceid forKey:@"deviceid"];
    [userInfoDic setObject:self.phone forKey:@"phone"];
    [userInfoDic setObject:self.password forKey:@"password"];
    
    return userInfoDic;
    
}

@end
