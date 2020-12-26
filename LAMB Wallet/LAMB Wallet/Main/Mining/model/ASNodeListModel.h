//
//  ASNodeListModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASNodeListCommissionModel : ASModel

@property (nonatomic, copy) NSString *max_rate; //
@property (nonatomic, copy) NSString *max_change_rate; //
@property (nonatomic, copy) NSString *update_time; //
@property (nonatomic, copy) NSString *rate; //

@end

@interface ASNodeListDescriptionModel : ASModel

@property (nonatomic, copy) NSString *identity; //
@property (nonatomic, copy) NSString *details; //
@property (nonatomic, copy) NSString *moniker; //
@property (nonatomic, copy) NSString *website; //

@end

@interface ASNodeListModel : ASModel

@property (nonatomic, copy) NSString *jailed; //
@property (nonatomic, assign) NSInteger status; // 0已解绑 1解绑中 2// 可用
@property (nonatomic, copy) NSString *tokens; // 质押token
@property (nonatomic, copy) NSString *unbonding_time; //
@property (nonatomic, copy) NSString *delegator_shares; //
@property (nonatomic, copy) NSString *consensus_pubkey; //
@property (nonatomic, copy) NSString *operator_address; //
@property (nonatomic, copy) NSString *min_self_delegation; //
@property (nonatomic, copy) NSString *unbonding_height; //
@property (nonatomic, copy) NSString *persent; // 质押token 占比
@property (nonatomic, strong) ASNodeListDescriptionModel *descriptions; //
@property (nonatomic, strong) ASNodeListCommissionModel *commission; //

@property (nonatomic, copy) NSString *delegator_address;// 质押账号地址
@property (nonatomic, copy) NSString *validator_address;// 节点地址
@property (nonatomic, copy) NSString *shares;// 质押量总量

@property (nonatomic, copy) NSString *winLamb;// 单个节点自己获取lamb收益
@property (nonatomic, copy) NSString *utbb;// 单个节点自己质押tbb量

@end

NS_ASSUME_NONNULL_END

/*/
 {
     jailed = 1;
     status = 1;
     tokens = "1273054930";
     unbonding_time = "2021-01-05T01:08:09.48777816Z";
     delegator_shares = "1276623760.340315468156649802";
     consensus_pubkey = "lambdavalconspub1zcjduepqy99a8hpajv4qjdq0hjk5ncc95pe8rpagtsgssxnakethj33y8mkqhv7xjc";
     commission = {
         max_rate = "0.250000000000000000";
         max_change_rate = "0.050000000000000000";
         update_time = "2019-09-07T23:50:31.619945428Z";
         rate = "0.250000000000000000";
     };
     operator_address = "lambdavaloper1pxxhhjwfudnzt0xglxqvamcuzpvqjrne7nztk3";
     description = {
         identity = "";
         details = "";
         moniker = "成都颐汇矿池";
         website = "";
     };
     min_self_delegation = "666666666";
     unbonding_height = "2098447";
 }
*/
