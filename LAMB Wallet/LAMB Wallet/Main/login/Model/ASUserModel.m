//
//  ASUserModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/3.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASUserModel.h"
#import <YYCategories/NSData+YYAdd.h>

@implementation ASUserModel

- (NSString *)path {
    return @"44'/364'/0'/0/0";
}

- (NSString *)publicKey {
    
    if (self.lambMnemonic) {
        return [self.lambKeyChain.key.publicKey hexString];
    }else{
        return _publicKey;
    }
}

- (NSString *)privateKey {
    if (self.lambMnemonic) {
        return [self.lambKeyChain.key.privateKey hexString];
    }else{
        return _privateKey;
    }
}

- (NSString *)publicKeyBase64 {
    if (self.lambMnemonic) {
        return [self.lambKeyChain.key.publicKey base64EncodedString];
    }else{
        return _publicKeyBase64;
    }
}

- (NSString *)privateKeyBase64 {
    if (self.lambMnemonic) {
        return [self.lambKeyChain.key.privateKey base64EncodedString];
    }else{
        return _privateKeyBase64;
    }
}

- (NSString *)address {
    
    return _address;
}

- (void)setLambMnemonic:(BTCMnemonic *)lambMnemonic {
    
    if (lambMnemonic) {
        _lambMnemonic = lambMnemonic;
        self.lambKeyChain = [lambMnemonic.keychain derivedKeychainWithPath:[LambUtils shareInstance].currentUser.path];
        self.privateKey = [self.lambKeyChain.key.privateKey hexString];
        self.publicKey = [self.lambKeyChain.key.publicKey hexString];
//        self.privateKey = [_lambMnemonic.keychain.key.privateKey base64EncodedString];
//        self.publicKey = [_lambMnemonic.keychain.key.publicKey base64EncodedString];
        NSString *addressString = [LambUtils getLambdaAddress:self.lambKeyChain.identifier prefix:@"lambda"];
        self.address = addressString;
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

@end
