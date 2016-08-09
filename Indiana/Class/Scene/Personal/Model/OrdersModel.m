//
//  OrdersModel.m
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrdersModel.h"

static NSString *const selfOrdersUrl = @"api/v1/orders?";
static NSString *const otherOrdersUrl = @"api/v1/orders/{userId}?";
@implementation OrdersModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSMutableDictionary *)parameters
                           block:(void (^)(OrdersListModel *ordersList,
                                           NSError *error))completion {
    NSString *orderUrl = nil;
    if ([[parameters allKeys] containsObject:@"userId"]) {
        orderUrl = [OrdersModel otherUrl:parameters];
    }else {
        //    UserInfoModel *user = [LocaldData achieveListDataType];
        [parameters setObject:@"123456789" forKey:@"push_token"];//user.push_token
        orderUrl = [OrdersModel selfUrl:parameters];
    }

    
    return [[DataService sharedClient] GET:orderUrl
                                parameters:@{}
                                completion:^(id response, NSError *error, NSDictionary *header) {
                                    
                                    OrdersListModel *ordersList =
                                    [MTLJSONAdapter modelOfClass:[OrdersListModel class]
                                              fromJSONDictionary:response
                                                           error:&error];
                                    completion(ordersList, error);
                                    
                                }];
}

+ (NSString *)selfUrl:(NSDictionary *)parameters {
    
    NSArray *keys = parameters.allKeys;
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL,selfOrdersUrl];
    for (NSString *key in keys) {
        url = [url stringByAppendingFormat:@"%@=%@&",key,parameters[key]];
    }
    return [url substringToIndex:[url length]-1];
}

+ (NSString *)otherUrl:(NSMutableDictionary *)parameters {

    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL,otherOrdersUrl];
    NSString *userId = parameters[@"userId"];
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:userId];
    [parameters removeObjectForKey:@"userId"];
    NSArray *keys = parameters.allKeys;
    for (NSString *key in keys) {
        url = [url stringByAppendingFormat:@"%@=%@&",key,parameters[key]];
    }
    return [url substringToIndex:[url length]-1];
}


@end
