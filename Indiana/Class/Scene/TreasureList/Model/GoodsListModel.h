//
//  GoodsListModel.h
//  Indiana
//
//  Created by QiQi on 16/6/30.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface GoodsListModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSMutableArray *goodsList;


@end
