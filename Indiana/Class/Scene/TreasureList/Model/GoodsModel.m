//
//  GoodsModel.m
//  Indiana
//
//  Created by Tagcare on 16/6/30.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsModel.h"
#import "DataService.h"

static NSString *const goodsListUrl = @"api/v1/schedule?";
static NSString *const goodsDetailUrl = @"api/v1/schedule/%@?sign=1";                                                                                               

@implementation GoodsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                           block:(void (^)(GoodsListModel *goodsList,
                                           NSError *error))completion {
  
    
    return [[DataService sharedClient] GET:[GoodsModel url:parameters]
                                parameters:@{}
                                completion:^(id response, NSError *error, NSDictionary *header) {
                                    
                                    GoodsListModel *goodsList =
                                    [MTLJSONAdapter modelOfClass:[GoodsListModel class]
                                              fromJSONDictionary:response[@"data"]
                                                           error:&error];
                                    completion(goodsList, error);
                                    
                                }];
}

//详情
- (NSURLSessionDataTask *)detailsblock:(void (^)(GoodsModel *goodsModel,
                                                 NSError *error))completion {
    return [[DataService sharedClient] GET:[self detailUrl]
                                parameters:@{}
                                completion:^(id response, NSError *error, NSDictionary *header) {
                                    NSDictionary *data = response[@"data"];
                                    GoodsModel *goods = [MTLJSONAdapter modelOfClass:[GoodsModel class]
                                                                  fromJSONDictionary:data[@"schedule"]
                                                                               error:&error];
                                    completion(goods, error);
                                }];
}

+ (NSString *)url:(NSDictionary *)parameters {
    
    NSArray * keys = parameters.allKeys;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_URL,goodsListUrl];
    for (NSString * key in keys) {
        url = [url stringByAppendingFormat:@"%@=%@&",key,parameters[key]];
    }
    return [url substringToIndex:[url length]-1];
}

- (NSString *)detailUrl {
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_URL,goodsDetailUrl];
    url = [url stringByReplacingOccurrencesOfString:@"%@" withString:self.scheduleId];
    return url;
}

@end
