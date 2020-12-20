//
//  ASProposalModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/20.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASModel.h"
#import <YYModel/NSObject+YYModel.h>

NS_ASSUME_NONNULL_BEGIN


@interface ASProposalTallyResultModel : ASModel

@property (nonatomic, copy) NSString *no; //
@property (nonatomic, copy) NSString *yes; //
@property (nonatomic, copy) NSString *no_with_veto; //
@property (nonatomic, copy) NSString *abstain; //

@end

@interface ASProposalValueAmountModel : ASModel

@property (nonatomic, copy) NSString *denom; //
@property (nonatomic, copy) NSString *amount; //

@end

@interface ASProposalValueModel : ASModel

@property (nonatomic, copy) NSString *title; //
@property (nonatomic, strong) ASProposalValueAmountModel *burn_amount; //
@property (nonatomic, copy) NSString *descriptions; //

@end

@interface ASProposalContentModel : ASModel

@property (nonatomic, copy) NSString *type; //
@property (nonatomic, strong) ASProposalValueModel *value; //

@end


@interface ASProposalModel : ASModel

@property (nonatomic, strong) ASProposalContentModel *content; //
@property (nonatomic, copy) NSString *submit_time; //
@property (nonatomic, copy) NSString *ids; //
@property (nonatomic, copy) NSString *proposal_status; //
@property (nonatomic, copy) NSString *voting_start_time; //
@property (nonatomic, copy) NSString *deposit_end_time; //
@property (nonatomic, copy) NSString *voting_end_time; //
@property (nonatomic, strong) ASProposalTallyResultModel *final_tally_result; //
@property (nonatomic, strong) NSArray<ASProposalValueAmountModel *> *total_deposit; //

@end

NS_ASSUME_NONNULL_END
