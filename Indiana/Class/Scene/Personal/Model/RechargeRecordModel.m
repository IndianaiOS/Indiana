//
//  RechargeRecordModel.m
//  Indiana
//
//  Created by Tagcare on 16/7/6.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "RechargeRecordModel.h"

static NSString *const rechargeRecordUrl = @"pay/rechargeRecord?";

@implementation RechargeRecordModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"rechargeId":@"id"
             };
}

+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                           block:(void (^)(RechargeRecordListModel *rechargeRecordList,
                                           NSError *error))completion {
    
    return [[DataService sharedClient] GET:[RechargeRecordModel url:parameters]
                                parameters:@{}
                                completion:^(id response, NSError *error, NSDictionary *header) {
                                    
                                    RechargeRecordListModel *rechargeRecordList =
                                    [MTLJSONAdapter modelOfClass:[RechargeRecordListModel class]
                                              fromJSONDictionary:response
                                                           error:&error];
                                    completion(rechargeRecordList, error);
                                    
                                }];
}

+ (NSString *)url:(NSDictionary *)parameters {
    
    NSArray * keys = parameters.allKeys;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_URL_RECHARGE,rechargeRecordUrl];
    for (NSString * key in keys) {
        url = [url stringByAppendingFormat:@"%@=%@&",key,parameters[key]];
    }
    return [url substringToIndex:[url length]-1];
}

@end
