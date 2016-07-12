//
//  OrdersListModel.m
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "OrdersListModel.h"
#import "OrdersModel.h"

@implementation OrdersListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+ (NSValueTransformer *)dataJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OrdersModel class]];
}

@end
