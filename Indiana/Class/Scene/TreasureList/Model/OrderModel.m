//
//  OrderModel.m
//  Indiana
//
//  Created by Tagcare on 16/7/12.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrderModel.h"

static NSString *const orderListUrl = @"http://192.168.0.65:8888/api/v1/orders/{userId}?state=1&pageNumber=1&pageSize=10";

@implementation OrderModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

- (NSURLSessionDataTask *)GETUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(OrderListModel *orderList, NSError *error))completion{
    return [[DataService sharedClient] GET:[OrderModel url:parameters] parameters:@{} completion:^(id response, NSError *error, NSDictionary *header) {
        OrderListModel *orderList = [MTLJSONAdapter modelOfClass:[OrderListModel class] fromJSONDictionary:response[@"data"] error:&error];
        completion(orderList,error);
    }];
}

+ (NSString *)url:(NSDictionary *)parameters {
    
    NSArray * keys = parameters.allKeys;
    NSString * url = [NSString stringWithFormat:@"%@",orderListUrl];
    for (NSString * key in keys) {
        url = [url stringByAppendingFormat:@"%@=%@&",key,parameters[key]];
    }
    return [url substringToIndex:[url length]-1];
}

@end
