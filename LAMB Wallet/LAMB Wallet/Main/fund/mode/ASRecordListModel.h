//
//  ASRecordListModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/3.
//  Copyright © 2021 fei. All rights reserved.
//
//  交易记录
#import "ASModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
{
    "height": "4",
    "txhash": "B3579546312F8A13380332747A4A71C8C1A1B0A679D232E361C85E21D66E04D2",
    "raw_log": "[{\"msg_index\":\"0\",\"success\":true,\"log\":\"\"}]",
    "logs": [{
        "msg_index": "0",
        "success": true,
        "log": ""
    }],
    "gas_wanted": "200000",
    "gas_used": "28658",
    "tags": [{
        "key": "action",
        "value": "send"
    }, {
        "key": "sender",
        "value": "lambda1ymms062l3v55tyfkeqp605psvdh4za78k6ufcw"
    }, {
        "key": "address",
        "value": "lambda1ymms062l3v55tyfkeqp605psvdh4za78k6ufcw"
    }, {
        "key": "recipient",
        "value": "lambda1cun5lrsmrhfzecr4mqhq2vsmqg3648tskgqtq7"
    }, {
        "key": "address",
        "value": "lambda1cun5lrsmrhfzecr4mqhq2vsmqg3648tskgqtq7"
    }],
    "tx": {
        "type": "auth/StdTx",
        "value": {
            "msg": [{
                "type": "cosmos-sdk/MsgSend",
                "value": {
                    "from_address": "lambda1ymms062l3v55tyfkeqp605psvdh4za78k6ufcw",
                    "to_address": "lambda1cun5lrsmrhfzecr4mqhq2vsmqg3648tskgqtq7",
                    "amount": [{
                        "denom": "ulamb",
                        "amount": "5000000000000"
                    }, {
                        "denom": "utbb",
                        "amount": "1000000000"
                    }]
                }
            }],
            "fee": {
                "amount": null,
                "gas": "200000"
            },
            "signatures": [{
                "pub_key": {
                    "type": "tendermint/PubKeySecp256k1",
                    "value": "A5XNUW54OPOyt9IDQrsXZZYkcFbMt/LokissJFHwnxc8"
                },
                "signature": "gQzDFxLI30/l8AZMByxRRzFi+FBIECoS0/YeuRYdKRtYhWcuwnBwWBbDAWSGJa+yFs6WJsyTgxHIe+iWoshbMA=="
            }],
            "memo": ""
        }
    },
    "timestamp": "2020-12-28T10:50:33Z"
 }
 */

@interface ASRecordTxValueSigPubkeyModel : ASModel

@property (nonatomic, copy) NSString *type; // name
@property (nonatomic, copy) NSString *value; // name

@end

@interface ASRecordTxValueSigModel : ASModel

@property (nonatomic, strong) ASRecordTxValueSigPubkeyModel *pub_key; // name
@property (nonatomic, copy) NSString *signature; // name

@end

@interface ASRecordTxValueFeeModel : ASModel

@property (nonatomic, copy) NSString *amount; // name
@property (nonatomic, copy) NSString *gas; // name

@end

@interface ASRecordTxValueMsgAmountModel : ASModel

@property (nonatomic, copy) NSString *amount; // name
@property (nonatomic, copy) NSString *denom; // name

@end

@interface ASRecordTxValueMsgValueModel : ASModel

@property (nonatomic, copy) NSString *from_address; // name
@property (nonatomic, copy) NSString *to_address; // name
@property (nonatomic, strong) NSArray <ASRecordTxValueMsgAmountModel *>*amount; // name

@end

@interface  ASRecordTxValueMsgModel: ASModel

@property (nonatomic, copy) NSString *type; // name
@property (nonatomic, strong) ASRecordTxValueMsgValueModel *value; // name

@end

@interface ASRecordTxValueModel : ASModel

@property (nonatomic, strong) ASRecordTxValueFeeModel *fee; // name
@property (nonatomic, copy) NSString *memo; // name
@property (nonatomic, strong) NSArray <ASRecordTxValueMsgModel *> *msg; // name
@property (nonatomic, strong) NSArray <ASRecordTxValueSigModel *>*signatures; // name

@end


@interface ASRecordTxModel : ASModel

@property (nonatomic, copy) NSString *type; // name
@property (nonatomic, strong) ASRecordTxValueModel *value; // name

@end


@interface ASRecordListTagModel : ASModel

@property (nonatomic, copy) NSString *key; // name
@property (nonatomic, copy) NSString *value; // name

@end

@interface ASRecordListLogModel : ASModel

@property (nonatomic, copy) NSString *log; // name
@property (nonatomic, copy) NSString *msg_index; // name
@property (nonatomic, assign) BOOL success; // name

@end

@interface ASRecordListModel : ASModel

@property (nonatomic, assign) BOOL sender; // 发送 还是接收

@property (nonatomic, copy) NSString *gas_used; // name
@property (nonatomic, copy) NSString *gas_wanted; // name
@property (nonatomic, copy) NSString *height; // name
@property (nonatomic, copy) NSString *timestamp; // name
@property (nonatomic, copy) NSString *txhash; // name
@property (nonatomic, strong) NSArray <ASRecordListLogModel *> *logs; // name
@property (nonatomic, strong) NSArray <ASRecordListTagModel *> *tags; // name
@property (nonatomic, copy) NSString *raw_log; // name
@property (nonatomic, strong) ASRecordTxModel *tx; // name

@end

NS_ASSUME_NONNULL_END
