//
//  RechargeRecordModel.h
//  Indiana
//
//  Created by Tagcare on 16/7/6.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RechargeRecordListModel.h"

@interface RechargeRecordModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong)NSString *rechargeId;
@property (nonatomic, strong)NSString *channel;
@property (nonatomic, strong)NSString *amount;
@property (nonatomic, strong)NSString *pay;
@property (nonatomic, strong)NSString *amountAndPayTime;
@property (nonatomic, strong)NSString *subject;
@property (nonatomic, strong)NSString *body;
@property (nonatomic, strong)NSString *clientIp;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSString *pingOrderNo;



//列表
+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                           block:(void (^)(RechargeRecordListModel *rechargeRecordList,
                                           NSError *error))completion;

@end
