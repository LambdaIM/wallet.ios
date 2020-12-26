//
//  ASNodeListModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASNodeListModel.h"
@implementation ASNodeListCommissionModel

@end

@implementation ASNodeListDescriptionModel

@end

@implementation ASNodeListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"descriptions" : [ASNodeListDescriptionModel class],
        @"commission":[ASNodeListCommissionModel class]
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"descriptions" : @"description"};
}

@end
