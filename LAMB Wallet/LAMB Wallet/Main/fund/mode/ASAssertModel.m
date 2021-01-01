//
//  ASAssertModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/31.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASAssertModel.h"

@implementation ASAssertPubKeyModel

@end

@implementation ASAssertValueModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"public_key" : [ASAssertPubKeyModel class],
        @"coins" : [ASProposalValueAmountModel class]
    };
}
@end

@implementation ASAssertModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"value" : [ASAssertValueModel class]
    };
}

@end
