//
//  NSString+KBChange.m
//  LAMB Wallet
//
//  Created by fei on 2020/11/10.
//  Copyright © 2020 fei. All rights reserved.
//

#import "NSString+KBChange.h"
#define kDEFAULTSTR [NSString stringWithFormat:@"0"]

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
 
- (NSString *) persentString {
    return [NSString stringWithFormat:@"%.2f%%",[self doubleValue] * 100];
}

/*将UTC日期字符串转为本地时间字符串
 eg: 2017-10-25 02:07:39  -> 2017-10-25 10:07:39
 */
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr {
    if (utcStr) {
        if ([utcStr containsString:@"T"]) {
            utcStr = [[[utcStr componentsSeparatedByString:@"."] firstObject] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        }
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        format.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];//GMT
        NSDate *utcDate = [format dateFromString:utcStr];
        format.timeZone = [NSTimeZone localTimeZone];
        NSString *dateString = [format stringFromDate:utcDate];
        return dateString;
    }
    return @"";
}

- (NSString *)getShowNumber:(NSString *) point {
    
    NSString *formatString = [NSString stringWithFormat:@"%%.%@f",point];
    return [NSString hanleNums:[NSString deleteFloatAllZero:[NSString stringWithFormat:formatString,[self doubleValue] / 1000000]]];
}

+ (NSString *)hanleNums:(NSString *)numbers{
    
    NSString *firstString = numbers;
    NSString *lastString = nil;
    if ([numbers containsString:@"."]) {
        firstString = [[numbers componentsSeparatedByString:@"."] firstObject];
        lastString = [[numbers componentsSeparatedByString:@"."] lastObject];
    }
    
    NSString *str = [firstString substringWithRange:NSMakeRange(firstString.length%3, firstString.length-firstString.length%3)];
    NSString *strs = [firstString substringWithRange:NSMakeRange(0, firstString.length%3)];
    for (int  i =0; i < str.length; i =i+3) {
        NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
        strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
    }
    if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
        strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
    }
    if (lastString) {
        strs = [NSString stringWithFormat:@"%@.%@",strs,lastString];
    }
    return strs;
}

// 删除字符串末尾0
+(NSString*)deleteFloatAllZero:(NSString*)string
{
    NSArray * arrStr=[string componentsSeparatedByString:@"."];
    NSString *str=arrStr.firstObject;
    NSString *str1=arrStr.lastObject;
    while ([str1 hasSuffix:@"0"]) {
        str1=[str1 substringToIndex:(str1.length-1)];
    }
    return (str1.length>0)?[NSString stringWithFormat:@"%@.%@",str,str1]:str;
}


#pragma mark 加减格式化
+ (NSString *)formatStrWithOldStr:(NSString *)str isPlus:(BOOL)isPlus{
    NSString *returnStr;
    if ([str containsString:@"."]) {
        NSArray *tempArr = [str componentsSeparatedByString:@"."];
        NSInteger i = [tempArr[1] length];
        double temp = pow(0.1, i);
        double j = [str doubleValue];
        if (isPlus) {
            j += temp;
        }else{
            j -= temp;
        }
        NSString *format = [NSString stringWithFormat:@"%%.%ldf",(long)i];
        str = [NSString stringWithFormat:format,j];
        returnStr = str;
    }else{
        NSInteger tempFloat = [str integerValue];
        if (isPlus) {
            tempFloat += 1;
        }else{
            tempFloat -= 1;
        }
        str = [NSString stringWithFormat:@"%ld",(long)tempFloat];
        returnStr = str;
    }
    return returnStr;
}

#pragma mark 格式化
+ (NSString *)formatDecimalWithStr:(NSString *)str{//直接格式化
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithString:str];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *formatStr = [NSString stringWithFormat:@"%@",roundedOunces];
    return formatStr;
}
+ (NSString *)formatDecimalWithStr:(NSString *)str andLenth:(int )lenth{//自定义位数格式化
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:lenth raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithString:str];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *formatStr = [NSString stringWithFormat:@"%@",roundedOunces];
    return formatStr;
}
+ (NSString *)formatWithMultyStrings:(NSString *)firstStr andSecondStr:(NSString *)secondString{//乘法
    if ([firstStr doubleValue] <= 0 || [secondString doubleValue] <=0) {return kDEFAULTSTR;}
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *multy1 = [NSDecimalNumber decimalNumberWithString:firstStr];
    NSDecimalNumber *multy2 = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *multy = [multy1 decimalNumberByMultiplyingBy:multy2];
    NSDecimalNumber *roundedOunces = [multy decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *formatStr = [NSString stringWithFormat:@"%@",roundedOunces];
    return formatStr;
}
+ (NSString *)formatWithDivStrings:(NSString *)firstStr andSecondStr:(NSString *)secondString{//除法
    if ([firstStr doubleValue] <= 0) {return kDEFAULTSTR;}
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *multy1 = [NSDecimalNumber decimalNumberWithString:firstStr];
    NSDecimalNumber *multy2 = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *div = [multy1 decimalNumberByDividingBy:multy2];
    NSDecimalNumber *roundedOunces = [div decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *formatStr = [NSString stringWithFormat:@"%@",roundedOunces];
    return formatStr;
}

@end
