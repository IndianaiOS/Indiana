//
//  OrderModel.h
//  Indiana
//
//  Created by Tagcare on 16/7/12.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "OrderListModel.h"

@interface OrderModel : MTLModel <MTLJSONSerializing>

@property(nonatomic,strong)NSString *scheduleld;
@property(nonatomic,strong)NSString *scheduleNo;
@property(nonatomic,strong)NSString *goodsId;
@property(nonatomic,strong)NSString *goodsName;
@property(nonatomic,strong)NSString *joinCount;
@property(nonatomic,strong)NSString *numbers;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *won;
@property(nonatomic,strong)NSString *luckNumber;

- (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                           block:(void(^)(OrderListModel *orderList,NSError *error))completion;

@end
