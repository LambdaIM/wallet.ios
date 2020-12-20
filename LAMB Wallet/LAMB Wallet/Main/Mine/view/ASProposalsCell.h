//
//  ASProposalsCell.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/20.
//  Copyright © 2020 fei. All rights reserved.
//
//  提案列表
#import "ASTableViewCell.h"
#import "ASProposalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASProposalsCell : ASTableViewCell

@property (nonatomic,strong)ASProposalModel *model;

@end

NS_ASSUME_NONNULL_END
