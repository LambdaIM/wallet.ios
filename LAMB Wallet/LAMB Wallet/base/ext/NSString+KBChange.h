//
//  NSString+KBChange.h
//  LAMB Wallet
//
//  Created by fei on 2020/11/10.
//  Copyright © 2020 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KBChange)
 
//将16进制字符串转换为NSData
- (NSData *)my_dataFromHexString;
// 删除字符串末尾0
+(NSString*)deleteFloatAllZero:(NSString*)string;
// 格式化"1,000"
+ (NSString *)hanleNums:(NSString *)numbers;
// "100%"
- (NSString *) persentString;

+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr ;

- (NSString *)getShowNumber:(NSString *) point ;

+ (NSString *)formatStrWithOldStr:(NSString *)str isPlus:(BOOL)isPlus;

+ (NSString *)formatDecimalWithStr:(NSString *)str;
+ (NSString *)formatDecimalWithStr:(NSString *)str andLenth:(int )lenth;
+ (NSString *)formatWithMultyStrings:(NSString *)firstStr andSecondStr:(NSString *)secondString;
+ (NSString *)formatWithDivStrings:(NSString *)firstStr andSecondStr:(NSString *)secondString;
@end

NS_ASSUME_NONNULL_END
