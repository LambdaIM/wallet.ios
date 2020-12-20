//
//  NSString+KBChange.m
//  LAMB Wallet
//
//  Created by fei on 2020/11/10.
//  Copyright © 2020 fei. All rights reserved.
//

#import "NSString+KBChange.h"

@implementation NSString (KBChange)

 
//将16进制字符串转换为NSData
- (NSData *)my_dataFromHexString
{
    const char *chars = [self UTF8String];
    int i = 0, len = (int)self.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len/2.0];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len)
    {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}
 

/*将UTC日期字符串转为本地时间字符串
 eg: 2017-10-25 02:07:39  -> 2017-10-25 10:07:39
 */
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];//GMT
    NSDate *utcDate = [format dateFromString:utcStr];
    format.timeZone = [NSTimeZone localTimeZone];
    NSString *dateString = [format stringFromDate:utcDate];
    return dateString;
}
@end
