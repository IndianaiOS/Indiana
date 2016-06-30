//
//  GoodsModel.m
//  Indiana
//
//  Created by Tagcare on 16/6/30.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsModel.h"
#import "DataService.h"

static NSString *const goodsListUrl = @"http://192.168.0.103:8888/api/v1/schedule";//?label=0&state=0&pageNumber=1&pageSize=10";
static NSString *const goodsDetailUrl = @"http://192.168.0.103:8888/api/v1/schedule/{scheduleId}?sign=0";

@implementation GoodsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                           block:(void (^)(GoodsListModel *goodsList,
                                           NSError *error))completion {
    NSDictionary *parameters = @{@"label":@"1",
                                 @"state":@"1",
                            @"pageNumber":@"1",
                              @"pageSize":@"10"};
    return [[DataService sharedClient] GET:goodsListUrl
                                parameters:parameters
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



@end
