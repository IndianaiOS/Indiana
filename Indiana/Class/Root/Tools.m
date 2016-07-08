//
//  Tools.m
//  Indiana
//
//  Created by Tagcare on 16/7/7.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSString *)timestampSwitchTime:(NSString *)timestamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];

    return [formatter stringFromDate:date];
}

@end
