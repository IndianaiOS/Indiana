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
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];

    return [formatter stringFromDate:date];
    
}

+ (NSString *)imageChangeBase64:(UIImage *)image {
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    NSString *imageDataString=[data base64EncodedStringWithOptions:0];
    return imageDataString;
    
}

@end
