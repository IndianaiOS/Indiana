//
//  GoodsListModel.m
//  Indiana
//
//  Created by QiQi on 16/6/30.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "GoodsListModel.h"
#import "GoodsModel.h"

@implementation GoodsListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+ (NSValueTransformer *)goodsListJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GoodsModel class]];
}

@end
