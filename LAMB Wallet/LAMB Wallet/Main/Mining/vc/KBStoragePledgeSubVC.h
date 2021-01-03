//
//  KBStoragePledgeSubVC.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//
// 我的质押
#import "ASRefreshVC.h"
#import "ZJScrollPageViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface KBStoragePledgeSubVC : ASRefreshVC<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, assign) BOOL bund; // 绑定中的、解绑中的

@end

NS_ASSUME_NONNULL_END
