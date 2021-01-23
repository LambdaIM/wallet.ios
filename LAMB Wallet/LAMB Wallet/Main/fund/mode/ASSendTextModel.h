//
//  ASSendTextModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/21.
//  Copyright © 2021 fei. All rights reserved.
//
//  发送交易 模型
#import "ASModel.h"
// lambda1s6lujxu6evv969t86hpkcr0t6j6fxe0pz33e5s

NS_ASSUME_NONNULL_BEGIN
/**
     * tx : {"msg":[{"type":"cosmos-sdk/MsgSend","value":{"amount":[{"amount":"1000000","denom":"ulamb"}],"from_address":"lambda1prrcl9674j4aqrgrzmys5e28lkcxmntx2gm2zt","to_address":"lambda1hynqrp2f80jqs86gu8nd5wwcnek2wwd3esszg0"}}],"fee":{"amount":[{"amount":"101745","denom":"ulamb"}],"gas":"40698"},"signatures":[{"signature":"fa9bUlNRA3qa9PEYR2py6CgpQbbqVsuKhJRowMdlf90byj7M/2B1YQsu6EPAk1V/tLkKiNwEadkAKNFUxZngGA==","pub_key":{"type":"tendermint/PubKeySecp256k1","value":"AjmQ01Z+IoHuKLdPaFzV6IJQB88ahW2qv2rEw2H4B5dq"}}],"memo":""}
     * mode : async
     */

@interface ASSendPubKeyModel : ASModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;

@end


@interface ASSendAmountModel : ASModel

@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *denom;

@end

@interface ASSendSignaturesModel : ASModel

@property (nonatomic, copy) NSString *signature;
@property (nonatomic, strong) ASSendPubKeyModel *pub_key;

@end

@interface ASSendMsgValueModel : ASModel

@property (nonatomic, strong) NSArray <ASSendAmountModel *> *amount;
@property (nonatomic, copy) NSString *to_address;
@property (nonatomic, copy) NSString *from_address;

@end

@interface ASSendMsgModel : ASModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) ASSendMsgValueModel *value;

@end

@interface ASSendFeeModel : ASModel

@property (nonatomic, strong) NSArray <ASSendAmountModel *>*amount;
@property (nonatomic, copy) NSString *gas;

@end

@interface ASSendTxtModel : ASModel

@property (nonatomic, strong) ASSendFeeModel *fee;// 手续费
@property (nonatomic, copy) NSString *memo;// 备注
@property (nonatomic, strong) NSArray <ASSendMsgModel *> *msg;// 发送消息体
@property (nonatomic, strong) NSArray <ASSendSignaturesModel *> *signatures;// 签名

@end

@interface ASSendTextModel : ASModel

@property (nonatomic, copy) NSString *mode; // async 同步
@property (nonatomic, strong) ASSendTxtModel *tx;

@end

// 请求gas base参数
@interface ASSendTextSignModel : ASModel

@property (nonatomic, copy) NSString *account_number;  //通过用户信息获取
@property (nonatomic, copy) NSString *chain_id; //链的版本号 通过最新的区块信息获取
@property (nonatomic, strong) ASSendFeeModel *fee;
@property (nonatomic, copy) NSString *memo;// 备注
@property (nonatomic, strong) NSArray <ASSendMsgModel *> *msgs;// 发送消息体
@property (nonatomic, copy) NSString *sequence;  //通过获取用户信息接口获取

@end

// 请求gas base参数
@interface ASSendTextGasBaseModel : ASModel

@property (nonatomic, copy) NSString *sequence;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *account_number;
@property (nonatomic, copy) NSString *chain_id;
@property (nonatomic, assign) BOOL simulate;
@property (nonatomic, copy) NSString *memo;

@end
// 请求gas 参数
@interface ASSendTextGasModel : ASModel

@property (nonatomic, copy) NSString *from_address;
@property (nonatomic, copy) NSString *to_address;
@property (nonatomic, strong) NSArray <ASSendAmountModel *> *amount;
@property (nonatomic, strong) ASSendTextGasBaseModel*base_req;

@end

NS_ASSUME_NONNULL_END
