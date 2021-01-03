//
//  ASRecordListModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/3.
//  Copyright © 2021 fei. All rights reserved.
//

#import "ASRecordListModel.h"


@implementation ASRecordTxValueSigPubkeyModel

@end
@implementation ASRecordTxValueSigModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"pub_key" : [ASRecordTxValueSigPubkeyModel class],
    };
}

@end
@implementation ASRecordTxValueMsgModel

@end
@implementation ASRecordTxValueMsgAmountModel

@end
@implementation ASRecordTxValueMsgValueModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"amount" : [ASRecordTxValueMsgAmountModel class],
    };
}

@end
@implementation ASRecordTxValueFeeModel

@end
@implementation ASRecordTxValueModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"fee" : [ASRecordTxValueFeeModel class],
        @"msg" : [ASRecordTxValueMsgModel class],
        @"signatures" : [ASRecordTxValueSigModel class],
    };
}

@end
@implementation ASRecordTxModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"value" : [ASRecordTxValueModel class],
    };
}

@end
@implementation ASRecordListTagModel

@end
@implementation ASRecordListLogModel

@end

@implementation ASRecordListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"tx" : [ASRecordTxModel class],
        @"tags" : [ASRecordListTagModel class],
        @"logs" : [ASRecordListLogModel class]
    };
}

@end
