//
//  NSString+HexColor.h
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//
@import UIKit;
 
NS_ASSUME_NONNULL_BEGIN

@interface NSString (HexColor)

/// 获取十六进制色
@property(nonatomic,readonly) UIColor *hexColor;

@end

NS_ASSUME_NONNULL_END
