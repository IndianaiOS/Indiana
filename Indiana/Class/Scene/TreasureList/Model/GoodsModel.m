//
//  GoodsModel.m
//  Indiana
//
//  Created by Tagcare on 16/6/30.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsModel.h"
#import "DataService.h"

static NSString *const goodsListUrl = @"http://192.168.0.103:8888/api/v1/schedule?";//label=0&state=0&pageNumber=1&pageSize=10";
static NSString *const goodsDetailUrl = @"http://192.168.0.103:8888/api/v1/schedule/{scheduleId}?sign=0";

@implementation GoodsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                           block:(void (^)(GoodsListModel *goodsList,
                                           NSError *error))completion {
 
    return [[DataService sharedClient] GET:@"http://192.168.0.103:8888/api/v1/schedule?label=0&state=0&pageNumber=1&pageSize=10"//[GoodsModel url:asa]
                                parameters:@{}
                                completion:^(id response, NSError *error, NSDictionary *header) {
                                    
                                    GoodsListModel *goodsList =
                                    [MTLJSONAdapter modelOfClass:[GoodsListModel class]
                                              fromJSONDictionary:response
                                                           error:&error];
                                    completion(goodsList, error);
                                    
                                }];
}

//详情
- (NSURLSessionDataTask *)detailsblock:(void (^)(GoodsModel *goodsModel,
                                                 NSError *error))completion {
    return [[DataService sharedClient] GET:goodsDetailUrl
                                parameters:@{}
                                completion:^(id response, NSError *error, NSDictionary *header) {
                                    GoodsModel *goods = [MTLJSONAdapter modelOfClass:[GoodsModel class]
                                                                  fromJSONDictionary:response//response[@"object"]
                                                                               error:&error];
                                    completion(goods, error);
                                }];
}

+ (NSString *)url:(NSDictionary *)parameters {
    NSDictionary *asa = @{@"label":@"1",
                          @"state":@"1",
                          @"pageNumber":@"1",
                          @"pageSize":@"10"};
    NSArray * keys = parameters.allKeys;
    NSString * url = [NSString stringWithFormat:@"%@",goodsListUrl];
    for (NSString * key in keys) {
        url = [url stringByAppendingFormat:@"%@=%@&",key,parameters[key]];
    }
    return [url substringToIndex:[url length]-1];
}


@end
