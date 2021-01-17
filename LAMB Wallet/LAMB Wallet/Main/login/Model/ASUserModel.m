//
//  ASUserModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/3.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASUserModel.h"

@implementation ASUserModel

- (NSString *)path {
    return @"44'/364'/0'/0/0";
}

- (NSString *)publicKey {
    
    if (self.lambMnemonic) {
        return [self.lambKeyChain.key.publicKey hexString];
    }else{
        return nil;
    }
}

- (NSString *)privateKey {
    if (self.lambMnemonic) {
        return [self.lambKeyChain.key.privateKey hexString];
    }else{
        return nil;
    }
}

- (NSString *)address {
    if (self.lambMnemonic) {
        return self.lambKeyChain.key.address.publicAddress.string;
    }else{
        return nil;
    }
}

- (void)setLambMnemonic:(BTCMnemonic *)lambMnemonic {
    
    _lambMnemonic = lambMnemonic;
    self.lambKeyChain = [lambMnemonic.keychain derivedKeychainWithPath:[LambUtils shareInstance].currentUser.path];
}

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

@end
