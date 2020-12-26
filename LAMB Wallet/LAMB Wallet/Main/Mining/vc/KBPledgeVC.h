//
//  KBPledgeVC.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "BaseVC.h"
#import "ASNodeListModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 质押
@interface KBPledgeVC : BaseVC
/// 取消质押
@property(nonatomic) BOOL m_cancel;

@property (nonatomic, strong) ASNodeListModel *nodeDetailModel;    // 

@end

NS_ASSUME_NONNULL_END
