//
//  DataService.m
//  Indiana
//
//  Created by Tagcare on 16/4/25.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "DataService.h"

@implementation DataService

+ (DataService *)sharedClient {
    static DataService *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DataService alloc] init];
        
    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                   completion:(void (^)(id response, NSError *error,
                                        NSDictionary *header))completion {
    
    return [super GET:URLString
           parameters:@{}
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                  if (responseObject) {
                      completion(responseObject, nil, nil);
                  }
                  NSLog(@"task.state %ld",(long)task.state);

              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"task.state %ld",(long)task.state);
              }];
    
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    completion:
(void (^)(id response, NSError *error))completion {
    
    return [super POST:URLString
            parameters:parameters
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if (responseObject) {
                       completion(responseObject, nil);
                   }
                    NSLog(@"task.state %ld",(long)task.state);
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   completion(nil, error);
                    NSLog(@"task.state %ld",(long)task.state);
               }];

}

@end
