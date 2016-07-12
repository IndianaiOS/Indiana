//
//  OrdersListModel.h
//  Indiana
//
//  Created by QiQi on 16/7/11.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrdersListModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSMutableArray *data;

@end
