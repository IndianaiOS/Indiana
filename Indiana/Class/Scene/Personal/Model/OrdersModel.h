//
//  OrdersModel.h
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrdersListModel.h"

@interface OrdersModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong)NSString *ScheduleId;
@property (nonatomic, strong)NSString *scheduleNo;
@property (nonatomic, strong)NSString *goodsId;
@property (nonatomic, strong)NSString *goodsName;
@property (nonatomic, strong)NSString *joinCount;
@property (nonatomic, strong)NSString *numbers;
@property (nonatomic, strong)NSString *userId;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *won;
@property (nonatomic, strong)NSString *luckNumber;

//列表
+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSMutableDictionary *)parameters
                           block:(void (^)(OrdersListModel *orderList,
                                           NSError *error))completion;

@end
