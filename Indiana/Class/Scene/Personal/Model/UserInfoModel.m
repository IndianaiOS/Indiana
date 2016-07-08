//
//  UserInfoModel.m
//  Indiana
//
//  Created by Tagcare on 16/6/29.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "UserInfoModel.h"

static NSString *const loginUrl = @"api/v1/login";
static NSString *const phoneRegisterCAPTCHAUrl = @"api/v1/phoneRegisterCAPTCHA";
static NSString *const phoneRegisterUrl = @"api/v1/phoneRegister";

@implementation UserInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

- (NSURLSessionDataTask *)loginBlock:(void (^)(UserInfoModel *userInfoModel,
                                               NSError *error))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryObject]];
    [parameters setObject:self.uid forKey:@"uid"];
    [parameters setObject:self.nickname forKey:@"nickname"];
    [parameters setObject:self.gender forKey:@"gender"];
    [parameters setObject:self.avatar forKey:@"avatar"];
    [parameters setObject:self.logintype forKey:@"logintype"];

    return [[DataService sharedClient]
            POST:[self url:loginUrl]
            parameters:parameters
            completion:^(id response, NSError *error) {
                NSLog(@"response %@",response);
                UserInfoModel *userInfo = [MTLJSONAdapter modelOfClass:[UserInfoModel class]
                                            fromJSONDictionary:response[@"data"]
                                                         error:&error];
                completion(userInfo, error);
            }];
}

- (NSURLSessionDataTask *)phoneRegisterBlock:(void (^)(UserInfoModel *userInfoModel,
                                               NSError *error))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryObject]];
    [parameters setObject:self.captcha forKey:@"captcha"];
    
    return [[DataService sharedClient]
            POST:[self url:phoneRegisterUrl]
            parameters:parameters
            completion:^(id response, NSError *error) {
                UserInfoModel *userInfo = [MTLJSONAdapter modelOfClass:[UserInfoModel class]
                                                    fromJSONDictionary:response[@"data"]
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

- (NSMutableDictionary *)dictionaryObject{
    [self deviceInformation];
    NSMutableDictionary * userInfoDic = [[NSMutableDictionary alloc]init];
    
    [userInfoDic setObject:self.resolution forKey:@"resolution"];
    [userInfoDic setObject:self.os forKey:@"os"];
    [userInfoDic setObject:self.appversion forKey:@"appversion"];
    [userInfoDic setObject:self.deviceid forKey:@"deviceid"];
    [userInfoDic setObject:self.phone forKey:@"phone"];
    [userInfoDic setObject:self.password forKey:@"password"];
    
    
    
    return userInfoDic;
    
}

- (void)deviceInformation {
    //    1、得到当前屏幕的尺寸：
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat width = size_screen.width;
    CGFloat height = size_screen.height;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    self.resolution = [NSString stringWithFormat:@"%.fx%.f",width*scale_screen,height*scale_screen];
    
    UIDevice * device = [UIDevice currentDevice];
    self.os = [NSString stringWithFormat:@"%@%@",[device systemName],[device systemVersion]];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    self.appversion = [NSString stringWithFormat:@"V%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    
    self.deviceid = @" ";
}

- (NSString *)userid {
    if (_userid == nil) {
        _userid = @"";
    }
    return _userid;
}

- (NSString *)uid {
    if (_uid == nil) {
        _uid = @"";
    }
    return _uid;
}

- (NSString *)nickname {
    if (_nickname == nil) {
        _nickname = @"";
    }
    return _nickname;
}

- (NSString *)gender {
    if (_gender == nil) {
        _gender = @"";
    }
    return _gender;
}

- (NSString *)avatar {
    if (_avatar == nil) {
        _avatar = @"";
    }
    return _avatar;
}

- (NSString *)logintype {
    if (_logintype == nil) {
        _logintype = @"";
    }
    return _logintype;
}

- (NSString *)resolution {
    if (_resolution == nil) {
        _resolution = @"";
    }
    return _resolution;
}

- (NSString *)os {
    if (_os == nil) {
        _os = @"";
    }
    return _os;
}

- (NSString *)appversion {
    if (_appversion == nil) {
        _appversion = @"";
    }
    return _appversion;
}

- (NSString *)deviceid {
    if (_deviceid == nil) {
        _deviceid = @"";
    }
    return _deviceid;
}

- (NSString *)phone {
    if (_phone == nil) {
        _phone = @"";
    }
    return _phone;
}

- (NSString *)password {
    if (_password == nil) {
        _password = @"";
    }
    return _password;
}

- (NSString *)push_token {
    if (_push_token == nil) {
        _push_token = @"";
    }
    return _push_token;
}

- (NSString *)coin {
    if (_coin == nil) {
        _coin = @"";
    }
    return _coin;
}

- (NSString *)captcha {
    if (_captcha == nil) {
        _captcha = @"";
    }
    return _captcha;
}


@end
