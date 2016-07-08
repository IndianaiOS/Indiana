//
//  RechargeRecordListModel.m
//  Indiana
//
//  Created by Tagcare on 16/7/6.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "RechargeRecordListModel.h"
#import "RechargeRecordModel.h"

@implementation RechargeRecordListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+ (NSValueTransformer *)dataJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RechargeRecordModel class]];
}

@end
