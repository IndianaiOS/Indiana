//
//  DataService.h
//  Indiana
//
//  Created by Tagcare on 16/4/25.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "AFNetworking.h"
#import <Foundation/Foundation.h>

@interface DataService : AFHTTPSessionManager

+ (DataService *)sharedClient;
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                   completion:(void (^)(id response, NSError *error, NSDictionary *header))completion ;
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    completion:
(void (^)(id response, NSError *error))completion;

@end
