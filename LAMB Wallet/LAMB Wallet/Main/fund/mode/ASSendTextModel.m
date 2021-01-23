//
//  ASSendTextModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/21.
//  Copyright © 2021 fei. All rights reserved.
//

#import "ASSendTextModel.h"

@implementation ASSendPubKeyModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = PUB_TYPE;
        _value = [LambUtils shareInstance].currentUser.publicKeyBase64;
    }
    return self;
}

@end


@implementation ASSendAmountModel

@end

@implementation ASSendSignaturesModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pub_key" : [ASSendPubKeyModel class]
    };
}


- (instancetype)init {
    if (self = [super init]) {
        _pub_key = [[ASSendPubKeyModel alloc]init];
    }
    return self;
}

@end

@implementation ASSendMsgValueModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _from_address = [[LambUtils shareInstance] currentUser].address;
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"amount" : [ASSendAmountModel class]
    };
}

@end

@implementation ASSendMsgModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = TRANSFER;
        _value = [[ASSendMsgValueModel alloc] init];
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"value" : [ASSendMsgValueModel class]
    };
}

@end

@implementation ASSendFeeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"amount" : [ASSendAmountModel class]
    };
}

@end

@implementation ASSendTxtModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"fee" : [ASSendFeeModel class],
             @"msg" : [ASSendMsgModel class],
             @"signatures" : [ASSendSignaturesModel class]
    };
}

@end

@implementation ASSendTextModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tx = [[ASSendTxtModel alloc]init];
//        _mode = @"async";
        _mode = @"block";
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tx" : [ASSendTxtModel class]};
}

@end


@implementation ASSendTextSignModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fee = [[ASSendFeeModel alloc]init];
    }
    return self;
}

@end

@implementation ASSendTextGasBaseModel

- (instancetype)init {
    if (self = [super init]) {
        _simulate = YES;
        _from = [LambUtils shareInstance].currentUser.address;
    }
    return  self;
}

@end



@implementation ASSendTextGasModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        _from_address = [LambUtils shareInstance].currentUser.address;
        _base_req = [[ASSendTextGasBaseModel alloc] init];
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"amount" : [ASSendAmountModel class],
             @"base_req" : [ASSendTextGasBaseModel class]
    };
}


@end

