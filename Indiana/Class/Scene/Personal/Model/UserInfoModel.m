//
//  UserInfoModel.m
//  Indiana
//
//  Created by Tagcare on 16/6/29.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "UserInfoModel.h"

#define USER_DEFAULT @"userDefault"
static NSString *const loginUrl = @"login";
static NSString *const phoneRegisterCAPTCHAUrl = @"phoneRegisterCAPTCHA";
static NSString *const phoneRegisterUrl = @"phoneRegister";

@implementation UserInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

- (NSURLSessionDataTask *)loginBlock:(void (^)(UserInfoModel *userInfoModel,
                                               NSError *error))completion {
    //TODO:数据
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:[self dictionaryObject]];
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
    //TODO:数据
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:[self dictionaryObject]];
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

- (NSURLSessionDataTask *)phoneRegisterCAPTCHABlock:(void (^)(UserInfoModel *userInfoModel,
                                                       NSError *error))completion {
    //TODO: 只传手机号
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:[self dictionaryObject]];
    return [[DataService sharedClient]
            POST:[self url:phoneRegisterCAPTCHAUrl]
            parameters:parameters
            completion:^(id response, NSError *error) {
//                TODO: UserInfoModel *userInfo = [MTLJSONAdapter modelOfClass:[UserInfoModel class]
//                                                    fromJSONDictionary:response
//                                                                 error:&error];
//                completion(userInfo, error);
            }];
}

- (NSString *)url:(NSString *)str {
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_URL,str];
    return url;
}

//- (NSString *)userid {
//    if (_userid == nil) {
//        _userid = @"";
//    }
//    return _userid;
//}
//
//- (NSString *)uid {
//    if (_uid == nil) {
//        _uid = @"";
//    }
//    return _userid;
//}
//
//- (NSString *)nickname {
//    if (_nickname == nil) {
//        _nickname = @"";
//    }
//    return _nickname;
//}
//
//- (NSString *)gender {
//    if (_gender == nil) {
//        _gender = @"";
//    }
//    return _gender;
//}
//
//- (NSString *)avatar {
//    if (_avatar == nil) {
//        _avatar = @"";
//    }
//    return _avatar;
//}
//
//- (NSString *)logintype {
//    if (_logintype == nil) {
//        _logintype = @"";
//    }
//    return _logintype;
//}
//
//- (NSString *)resolution {
//    if (_resolution == nil) {
//        _resolution = @"";
//    }
//    return _resolution;
//}
//
//- (NSString *)os {
//    if (_os == nil) {
//        _os = @"";
//    }
//    return _os;
//}
//
//- (NSString *)appversion {
//    if (_appversion == nil) {
//        _appversion = @"";
//    }
//    return _appversion;
//}
//
//- (NSString *)deviceid {
//    if (_deviceid == nil) {
//        _deviceid = @"";
//    }
//    return _deviceid;
//}
//
//- (NSString *)phone {
//    if (_phone == nil) {
//        _phone = @"";
//    }
//    return _phone;
//}
//
//- (NSString *)password {
//    if (_password == nil) {
//        _password = @"";
//    }
//    return _password;
//}
//
//- (NSString *)push_token {
//    if (_push_token == nil) {
//        _push_token = @"";
//    }
//    return _push_token;
//}
//
//- (NSString *)coin {
//    if (_coin == nil) {
//        _coin = @"";
//    }
//    return _coin;
//}
//
//- (NSString *)captcha {
//    if (_captcha == nil) {
//        _captcha = @"";
//    }
//    return _captcha;
//}
//
//- (instancetype)init {
//    NSDictionary * userDefault = [[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT];
//    [self setValuesForKeysWithDictionary:userDefault];
//    return self;
//}
//
//-(void)saveDictionaryUser {
//    
//    NSLog(@"user %@",[self dictionaryObject]);
//    [[NSUserDefaults standardUserDefaults] setObject:[self dictionaryObject] forKey:USER_DEFAULT];
//    
//}

-(NSMutableDictionary *)dictionaryObject{
    
    NSMutableDictionary * userDefaultDictionary = [[NSMutableDictionary alloc]init];
    
    [userDefaultDictionary setObject:self.userid forKey:@"userid"];
    [userDefaultDictionary setObject:self.uid forKey:@"uid"];
    [userDefaultDictionary setObject:self.nickname forKey:@"nickname"];
    [userDefaultDictionary setObject:self.gender forKey:@"gender"];
    [userDefaultDictionary setObject:self.avatar forKey:@"avatar"];
    [userDefaultDictionary setObject:self.logintype forKey:@"logintype"];
    [userDefaultDictionary setObject:self.resolution forKey:@"resolution"];
    [userDefaultDictionary setObject:self.os forKey:@"os"];
    [userDefaultDictionary setObject:self.appversion forKey:@"appversion"];
    [userDefaultDictionary setObject:self.deviceid forKey:@"deviceid"];
    [userDefaultDictionary setObject:self.phone forKey:@"phone"];
    [userDefaultDictionary setObject:self.password forKey:@"password"];
    [userDefaultDictionary setObject:self.push_token forKey:@"push_token"];
    [userDefaultDictionary setObject:self.coin forKey:@"coin"];
    [userDefaultDictionary setObject:self.captcha forKey:@"captcha"];
    
    return userDefaultDictionary;
    
}

@end
