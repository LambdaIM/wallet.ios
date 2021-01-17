//
//  ASUserModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/3.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASUserModel : ASModel<NSCoding, NSCopying>

@property (nonatomic ,assign) NSInteger index;
@property (nonatomic ,copy) NSString *uid;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *salt;
@property (nonatomic ,copy) NSString *privateKey;
@property (nonatomic ,copy) NSString *publicKey;
@property (nonatomic ,copy) NSString *password;

@property (nonatomic, copy) NSString *path; // 

@property (nonatomic ,strong) NSArray *mnemonic;// 助剂词

@property (nonatomic,strong) BTCMnemonic *lambMnemonic;// 助记词

@property (nonatomic,strong) BTCKeychain *lambKeyChain;

@end

NS_ASSUME_NONNULL_END
