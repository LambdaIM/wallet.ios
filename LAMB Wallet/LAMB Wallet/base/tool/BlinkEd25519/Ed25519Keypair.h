//
//  Ed25519Keypair.h
//  LAMB Wallet
//
//  Created by fei on 2020/10/29.
//  Copyright © 2020 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ed25519Keypair : NSObject
@property (nonatomic,strong) NSData *publickey;//公钥32位

@property (nonatomic,strong) NSData *privatekey;//私钥64位

 
@end

NS_ASSUME_NONNULL_END
