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
 
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr ;

@end

NS_ASSUME_NONNULL_END
