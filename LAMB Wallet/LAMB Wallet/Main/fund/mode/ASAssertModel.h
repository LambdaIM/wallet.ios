//
//  ASAssertModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/31.
//  Copyright © 2020 fei. All rights reserved.
//
//  资产模型
#import "ASModel.h"
#import "ASProposalModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface LambWalltBackModel : ASModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *privateKey;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *salt;

@end


@interface ASAssertPubKeyModel : ASModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;

@end


@interface ASAssertValueModel : ASModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *account_number;
@property (nonatomic, copy) NSString *sequence;
@property (nonatomic, strong) ASAssertPubKeyModel *public_key;
@property (nonatomic, strong) NSArray <ASProposalValueAmountModel *> *coins;

@end


@interface ASAssertModel : ASModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) ASAssertValueModel *value;

@end

NS_ASSUME_NONNULL_END
