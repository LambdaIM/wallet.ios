//
//  LambUtils.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/9.
//  Copyright © 2021 fei. All rights reserved.
//

#import "LambUtils.h"



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

@end
