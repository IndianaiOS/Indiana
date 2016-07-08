//
//  RechargeRecordListModel.h
//  Indiana
//
//  Created by Tagcare on 16/7/6.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeRecordListModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSMutableArray *data;

@end
