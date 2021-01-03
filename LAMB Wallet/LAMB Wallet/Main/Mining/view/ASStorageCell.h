//
//  ASStorageCell.h
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/3.
//  Copyright © 2021 fei. All rights reserved.
//

#import "ASTableViewCell.h"
#import "ASNodeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASStorageCell : ASTableViewCell

@property (nonatomic, strong) ASNodeListModel *listModel;    // 

@end

NS_ASSUME_NONNULL_END
