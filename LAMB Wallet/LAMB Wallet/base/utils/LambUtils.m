//
//  LambUtils.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/9.
//  Copyright © 2021 fei. All rights reserved.
//

#import "LambUtils.h"
#import "segwit_addr.h"
#import "BTCMnemonic+KBMnemonic.h"

@implementation LambUtils


+ (instancetype) shareInstance {
    
    static id sharedInstance = nil;
    if (!sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[LambUtils alloc]init];
        });
    }
    return sharedInstance;
}


+ (void)saveUserInfo:(ASUserModel *)user {
    
    if (user) {
        
        YYCache *yyCache=[YYCache cacheWithName:kYYCacheUserIdentifer];
        
        ASUserModel *userModel = [LambUtils getUserInfoWithUserName:user.name];
        if (!userModel) {
            NSInteger count = [yyCache.diskCache totalCount];
            user.index = count;
            //根据key写入缓存value
            [yyCache setObject:user forKey:user.name];
            
            [[LambUtils shareInstance].localUserNames addObject:user.name];
            NSArray *array = [NSArray arrayWithArray:[LambUtils shareInstance].localUserNames];
            NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
            [defalut setObject:array forKey:kCacheUserNameIdentifer];
            [defalut synchronize];
        }
    }
}

+ (ASUserModel *)getUserInfoWithUserName:(NSString *)name {
    
    YYCache *yyCache=[YYCache cacheWithName:kYYCacheUserIdentifer];
    if ([[name stringByTrim] isNotBlank]) {
        BOOL isContains=[yyCache containsObjectForKey:[name stringByTrim]];
        if (isContains) {
            ASUserModel *user = (ASUserModel *)[yyCache objectForKey:[name stringByTrim]];
            return user;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

+ (void)removeUserByName:(NSString *)name {
    YYCache *yyCache=[YYCache cacheWithName:kYYCacheUserIdentifer];
    if ([[name stringByTrim] isNotBlank]) {
        //根据key移除缓存
        [yyCache removeObjectForKey:[name stringByTrim]];
    }
}



+ (void)removeAllUser {
    YYCache *yyCache=[YYCache cacheWithName:kYYCacheUserIdentifer];
    //移除所有缓存
    [yyCache removeAllObjects];
}


- (ASUserModel *)currentUser {
    if (!_currentUser) {
        _currentUser = [[ASUserModel alloc]init];
    }
    return _currentUser;
}

+ (NSString *) getLambdaAddress:(NSData *) addressData prefix:(NSString *) prefix{
    
    const char* hrp = (char*) [prefix cStringUsingEncoding:NSUTF8StringEncoding];

    const uint8_t* data = (const uint8_t*)[addressData bytes];
    
    size_t data_len = addressData.length;
                    
    char *final = bech32_encodeData(data, data_len, hrp);

    if (final) {
        NSString *lambAdressString = [[NSString alloc] initWithCString:final encoding:NSUTF8StringEncoding];
        return lambAdressString;
    }else{
        return @"";
    }
}

+ (NSString *)checkMnemonicWords:(NSArray *)words {
    
    NSArray *totalWordsArray = [BTCMnemonic wordListForType:BTCMnemonicWordListTypeEnglish];
    NSString *errorString = nil;
    for (NSString *wordString in words) {
        BOOL volatileValue = NO;
        for (NSString *totalWordString in totalWordsArray) {
            if ([wordString isEqualToString:totalWordString]) {
                volatileValue = YES;
                break;
            }
        }
        if (!volatileValue) {
            errorString = wordString;
        }
    }
    return errorString;
}

+ (void)logOut {
    
    [LambUtils shareInstance].currentUser = nil;
    // 移除当前用户信息
    YYCache *yyCache=[YYCache cacheWithName:kYYCacheCurrentUserIdentifer];
    [yyCache removeAllObjects];
}

+ (void)creatMnemonicWithWords:(NSArray *)words {
    
    BTCMnemonic *mnemonic = [[BTCMnemonic alloc] initWithWords:words password:@"" wordListType:BTCMnemonicWordListTypeEnglish];
    if (mnemonic) {
        [LambUtils shareInstance].currentUser.lambMnemonic = mnemonic;
        
        // 保存当前用户信息
        [LambUtils cofigLocalUserInfo];
        
        NSLog(@"钱包生成成功 \n 助记词 %@ \n publicKey %@ \n privateKey %@ \n address %@ \n btcpublick %@ \n btcPrivate %@\n btc_address %@ \n lamb_address %@",[[LambUtils shareInstance].currentUser.mnemonic componentsJoinedByString:@" "],[LambUtils shareInstance].currentUser.lambMnemonic.keychain.extendedPublicKey,[LambUtils shareInstance].currentUser.lambMnemonic.keychain.extendedPrivateKey ,[LambUtils shareInstance].currentUser.lambMnemonic.keychain.key.address.publicAddress.string,[LambUtils shareInstance].currentUser.publicKey,[LambUtils shareInstance].currentUser.privateKey,[[LambUtils shareInstance].currentUser.lambKeyChain.identifier hexString],[LambUtils shareInstance].currentUser.address);
    }
}

+ (void) cofigLocalUserInfo{
    
    YYCache *yyCache=[YYCache cacheWithName:kYYCacheCurrentUserIdentifer];
    [yyCache removeAllObjects];
    [yyCache setObject:[LambUtils shareInstance].currentUser forKey:kYYCacheCurrentUserIdentifer];
}

+ (BOOL) userLogin{
    
    YYCache *yyCache=[YYCache cacheWithName:kYYCacheCurrentUserIdentifer];
    if ([yyCache containsObjectForKey:kYYCacheCurrentUserIdentifer]) {
        ASUserModel *user = (ASUserModel *)[yyCache objectForKey:kYYCacheCurrentUserIdentifer];
        if (user) {
            [LambUtils shareInstance].currentUser = user;
            if (user.mnemonic) {
                [LambUtils creatMnemonicWithWords:user.mnemonic];
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (NSMutableArray *)localUserNames {
    if (!_localUserNames) {
        
        NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
        NSArray *tempArray = [defalut objectForKey:kCacheUserNameIdentifer];
        if (tempArray) {
            _localUserNames = [NSMutableArray arrayWithArray:tempArray];
        }else{
            _localUserNames = [NSMutableArray array];
        }
    }
    return _localUserNames;
}
@end
