//
//  KBVerifyNodeDetailVC.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "BaseVC.h"
#import "ASNodeListModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 验证节点详情
@interface KBVerifyNodeDetailVC : BaseVC

@property (nonatomic, strong) ASNodeListModel *nodeDetail;    // 节点详情

@end

NS_ASSUME_NONNULL_END
