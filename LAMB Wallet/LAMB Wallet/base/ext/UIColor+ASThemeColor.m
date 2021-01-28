//
//  UIColor+ASThemeColor.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//

#import "UIColor+ASThemeColor.h"

@implementation UIColor (ASThemeColor)
+ (UIColor *)baseLineColor {
    return [UIColor colorWithRed:234.0/255 green:234.0/255 blue:234.0/255 alpha:0.8];
}
/// 通过
+ (UIColor *) mPassColor{
    return [UIColor colorWithRed:4.0/255 green:125.0/255 blue:36.0/255 alpha:1];
}
+ (UIColor *)mNoPassColor{
    return [UIColor colorWithRed:220.0/255 green:62.0/255 blue:68.0/255 alpha:1];
}
+ (UIColor *) mPassColorAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:4.0/255 green:125.0/255 blue:36.0/255 alpha:alpha];
}
+ (UIColor *)mNoPassColorAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:220.0/255 green:62.0/255 blue:68.0/255 alpha:alpha];
}
+ (UIColor *)mMnemonicColor {
    return [UIColor colorWithHexString:@"000080"];
}

+ (UIColor *)mBaseViewColor {
    return  @"#F7F7F7".hexColor;
}

+ (UIColor *)mGasColor {
    return [UIColor colorWithRed:202.0/255 green:120.0/255 blue:60.0/255 alpha:1];
}

@end
