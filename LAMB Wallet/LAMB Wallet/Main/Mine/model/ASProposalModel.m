//
//  ASProposalModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/20.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASProposalModel.h"

@implementation ASProposalTallyResultModel

@end

@implementation ASProposalValueAmountModel

@end

@implementation ASProposalValueModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"descriptions" : @"description"};
}

@end

@implementation ASProposalContentModel

@end


@implementation ASProposalModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"content" : ASProposalTallyResultModel.class,
             @"final_tally_result" : ASProposalTallyResultModel.class,
             @"total_deposit" : [ASProposalValueAmountModel class] };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ids" : @"id"};
}
@end
