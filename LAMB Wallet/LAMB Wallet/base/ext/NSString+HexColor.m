//
//  NSString+HexColor.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "NSString+HexColor.h"
#import <YYCategories/UIColor+YYAdd.h>

@implementation NSString (HexColor)

-(UIColor *)hexColor {
    return [UIColor colorWithHexString:self];
}

@end
