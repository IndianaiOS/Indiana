//
//  PayService.m
//  Indiana
//
//  Created by Tagcare on 16/7/4.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "PayService.h"
#import "PingPP.h"

@implementation PayService

- (NSURLSessionDataTask *)payUserPingPP:(NSDictionary *)dic block:(void(^)(PayService *payModel))completion{
    return [[DataService sharedClient] POST:PAY_URL parameters:dic completion:^(id response, NSError *error) {
        self.charge = response;
    }];
}

- (void)pingPay{
    [Pingpp createPayment:self.charge
           viewController:nil
             appURLScheme:@"Indiana"
           withCompletion:^(NSString *result, PingppError *error) {
               if ([result isEqualToString:@"success"]) {
                   // 支付成功
                   NSLog(@"good! pay complete");
                   
                   NSNotification * notice = [NSNotification notificationWithName:@"paySuccessOrNo" object:nil userInfo:nil];
                   [[NSNotificationCenter defaultCenter]postNotification:notice];
                   [[DataService sharedClient] POST:PAY_VALIDATE_URL
                                         parameters:self.charge
                                         completion:^(id response, NSError *error) {
                                         }];
               } else {
                   // 支付失败或取消
                   NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
               }
           }];
}


/*- (void)payUserPingPP:(NSDictionary *)dic{
 
    [[DataService sharedClient] POST:
     //@"http://192.168.0.111:8889/pay/appReqController"
     @"http://123.5w6.181.65:8889/pay/appReqController"
                          parameters:dic
                          completion:^(id response, NSError *error) {
                              if (response) {
                                  NSLog(@"response:%@",response);
                                  NSString *charge = response;
                                  [Pingpp createPayment:charge
                                         viewController:nil
                                           appURLScheme:@"Indiana"
                                         withCompletion:^(NSString *result, PingppError *error) {
                                             if ([result isEqualToString:@"success"]) {
                                                 // 支付成功
                                                 NSLog(@"good! pay complete");
                                                 
                                                  NSNotification * notice = [NSNotification notificationWithName:@"paySuccessOrNo" object:nil userInfo:nil];
                                                  [[NSNotificationCenter defaultCenter]postNotification:notice];
                                                 [[DataService sharedClient] POST:
                                                  //@"http://192.168.0.111:8889/pay/appReqController"
                                                  @"http://123.56.181.65:8889/pay/appWebhooks"
                                                                       parameters:charge
                                                                       completion:^(id response, NSError *error) {
                                                                       }];
                                             } else {
                                                 // 支付失败或取消
                                                 NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
                                             }
                                         }];
                              }
                              else{
                                  NSLog(@"error:%@",error);
                              }
                          }];
}*/

@end
