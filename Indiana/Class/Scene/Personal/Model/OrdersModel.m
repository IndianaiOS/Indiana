//
//  OrdersModel.m
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrdersModel.h"

static NSString *const ordersUrl = @"api/v1/orders?";
@implementation OrdersModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSMutableDictionary *)parameters
                           block:(void (^)(OrdersListModel *ordersList,
                                           NSError *error))completion {
//    UserInfoModel *user = [LocaldData achieveListDataType];
    [parameters setObject:@"123456789" forKey:@"push_token"];//user.push_token
    
    return [[DataService sharedClient] GET:[OrdersModel url:parameters]
                                parameters:@{}
                                completion:^(id response, NSError *error, NSDictionary *header) {
                                    
                                    OrdersListModel *ordersList =
                                    [MTLJSONAdapter modelOfClass:[OrdersListModel class]
                                              fromJSONDictionary:response
                                                           error:&error];
                                    completion(ordersList, error);
                                
                                }];
}

+ (NSString *)url:(NSDictionary *)parameters {
    
    NSArray * keys = parameters.allKeys;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_URL,ordersUrl];
    for (NSString * key in keys) {
        url = [url stringByAppendingFormat:@"%@=%@&",key,parameters[key]];
    }
    return [url substringToIndex:[url length]-1];
}

@end
