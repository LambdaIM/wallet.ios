//
//  ASQRModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/3.
//  Copyright © 2021 fei. All rights reserved.
//
//  二维码
#import "ASModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASQRModel : ASModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *chainUrl;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
