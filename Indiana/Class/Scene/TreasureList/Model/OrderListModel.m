//
//  OrderListModel.m
//  Indiana
//
//  Created by Tagcare on 16/7/12.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrderListModel.h"
#import "OrderModel.h"

@implementation OrderListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+ (NSValueTransformer *)schedulePageJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OrderModel class]];
}

@end
