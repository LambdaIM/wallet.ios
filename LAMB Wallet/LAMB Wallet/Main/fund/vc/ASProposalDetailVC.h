//
//  ASProposalDetailVC.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/20.
//  Copyright © 2020 fei. All rights reserved.
//
//  提案详情
#import "ASRefreshVC.h"
#import "ASProposalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASProposalDetailVC : ASRefreshVC

@property (nonatomic, strong) ASProposalModel *model;    // 提案模型

@end

NS_ASSUME_NONNULL_END
