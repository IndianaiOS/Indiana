//
//  OrderListModel.h
//  Indiana
//
//  Created by Tagcare on 16/7/12.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface OrderListModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSMutableArray *schedulePage;

@end
