//
//  GoodsModel.h
//  Indiana
//
//  Created by Tagcare on 16/6/30.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "GoodsListModel.h"

@interface GoodsModel : MTLModel <MTLJSONSerializing>

@property(nonatomic,strong)NSString *scheduleId;
@property(nonatomic,strong)NSString *scheduleNo;
@property(nonatomic,strong)NSString *goodsId;
@property(nonatomic,strong)NSString *goodsName;
@property(nonatomic,strong)NSString *goodsIntro;
@property(nonatomic,strong)NSString *totalPrice;
@property(nonatomic,strong)NSString *integer;
@property(nonatomic,strong)NSString *copies;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSString *luckNumber;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *nikName;
@property(nonatomic,strong)NSString *lotteryNo;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *achieveTime;
@property(nonatomic,strong)NSString *openTime;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *nowCopies;
@property(nonatomic,strong)NSString *allNumber;
@property(nonatomic,strong)NSString *nextFlag;
@property(nonatomic,strong)NSString *indexImages;

//列表
+ (NSURLSessionDataTask *)GETUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                           block:(void (^)(GoodsListModel *goodsList,
                                           NSError *error))completion;

//详情
- (NSURLSessionDataTask *)detailsblock:(void (^)(GoodsModel *goodsModel,
                                                 NSError *error))completion;

@end
