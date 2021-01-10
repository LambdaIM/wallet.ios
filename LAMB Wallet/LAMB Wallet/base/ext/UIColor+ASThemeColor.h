//
//  UIColor+ASThemeColor.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYCategories/UIColor+YYAdd.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ASThemeColor)

/// 下划线
+ (UIColor *) baseLineColor;

/// 通过
+ (UIColor *) mPassColor;

/// 拒绝
+ (UIColor *) mNoPassColor;

+ (UIColor *) mPassColorAlpha:(CGFloat)alpha;
+ (UIColor *) mNoPassColorAlpha:(CGFloat)alpha;

/// 助剂词
+ (UIColor *) mMnemonicColor;

@end

NS_ASSUME_NONNULL_END
