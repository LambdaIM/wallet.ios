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

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"burn_amount" : [ASProposalValueAmountModel class]};
}


@end

@implementation ASProposalContentModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"value" : [ASProposalValueModel class] };
}


- (NSString *)typeString{
    
    NSString *typeString = [[self.type componentsSeparatedByString:@"/"]lastObject];
    
    if ([typeString isEqualToString:@"TextProposal"]) {
        return ASLocalizedString(@"文本");
    }else if ([typeString isEqualToString:@"BurnCoinsProposal"]) {
        return ASLocalizedString(@"销毁币");
    }else if ([typeString isEqualToString:@"CommunityPoolSpendProposal"]) {
        return ASLocalizedString(@"社区基金");
    }else if ([typeString isEqualToString:@"ParameterChangeProposal"]) {
        return ASLocalizedString(@"参数变更");
    }else if ([typeString isEqualToString:@"SoftwareUpgradeProposal"]) {
        return ASLocalizedString(@"软件升级");
    }else{
        return @"";
    }
}

@end


@implementation ASProposalModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"content" : [ASProposalTallyResultModel class],
             @"final_tally_result" : [ASProposalTallyResultModel class],
             @"total_deposit" : [ASProposalValueAmountModel class] ,
             @"min_deposit":[ASProposalValueAmountModel class],
             @"val_commission":[ASProposalValueAmountModel class],
             @"self_bond_rewards":[ASProposalValueAmountModel class]
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ids" : @"id"};
}

- (NSString *)proposal_status_string{
    
    if ([self.proposal_status isEqualToString:@"Rejected"]) {
        return ASLocalizedString(@"未通过");
    }else if ([self.proposal_status isEqualToString:@"Passed"]){
        return ASLocalizedString(@"通过");

    }else if ([self.proposal_status isEqualToString:@"DepositPeriod"]){
        return ASLocalizedString(@"押金阶段");

    }else if ([self.proposal_status isEqualToString:@"VotingPeriod"]){
        return ASLocalizedString(@"投票阶段");
    }else{
        return @"";
    }
}
@end
