//
//  KBWithdrawRewardSubVC.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "BaseVC.h"
#import "ZJScrollPageViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface KBWithdrawRewardSubVC : BaseVC<ZJScrollPageViewChildVcDelegate>
/// 是否是节点收益
@property(nonatomic) BOOL m_nodeRevenue;
@end

NS_ASSUME_NONNULL_END
