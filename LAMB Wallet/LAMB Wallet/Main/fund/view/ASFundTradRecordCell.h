//
//  ASFundTradRecordCell.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASTableViewCell.h"
#import "ASRecordListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASFundTradRecordCell : ASTableViewCell

@property (nonatomic, strong) ASRecordListModel *model;    // listModel

@end

NS_ASSUME_NONNULL_END
