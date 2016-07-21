//
//  PayService.h
//  Indiana
//
//  Created by Tagcare on 16/7/4.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayService : NSObject
@property(strong,nonatomic)NSString *charge;

- (NSURLSessionDataTask *)payUserPingPP:(NSDictionary *)dic block:(void(^)(PayService *payModel))completion;
- (void)pingPay;

@end
