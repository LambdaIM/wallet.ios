//
//  NSData+KBChange.h
//  LAMB Wallet
//
//  Created by fei on 2020/11/10.
//  Copyright © 2020 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KBChange)
 
//将字符串转换为16进制
- (NSString *)my_hexString;

//16进制转换为比特数组
- (NSArray *)my_hexToBitArray;
 
@end

NS_ASSUME_NONNULL_END
