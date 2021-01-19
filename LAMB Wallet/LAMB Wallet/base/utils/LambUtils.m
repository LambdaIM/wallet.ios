//
//  LambUtils.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/9.
//  Copyright © 2021 fei. All rights reserved.
//

#import "LambUtils.h"
#import "segwit_addr.h"

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
    
    YYCache *yyCache=[YYCache cacheWithName:kYYCacheUserIdentifer];
    if (user) {
        NSInteger count = [yyCache.diskCache totalCount];
        user.index = count;
        //根据key写入缓存value
        [yyCache setObject:user forKey:user.name];
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
@end
