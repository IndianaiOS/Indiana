//
//  Tools.h
//  Indiana
//
//  Created by Tagcare on 16/7/7.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+ (NSString *)timestampSwitchTime:(NSString *)timestamp;
+ (NSString *)imageChangeBase64:(UIImage *)image;

@end
