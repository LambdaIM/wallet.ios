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
@end
