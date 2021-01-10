//
//  ASUserModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/3.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASUserModel.h"

@implementation ASUserModel


- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

@end
