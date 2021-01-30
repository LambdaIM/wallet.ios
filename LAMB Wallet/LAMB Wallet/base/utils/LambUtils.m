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
#import <YYCategories/NSData+YYAdd.h>
#import "CBSecp256k1.h"

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
        
        
        NSLog(@"钱包生成成功 \n 助记词 %@ \n publicKey %@ \n privateKey %@ \n address %@ \n btcpublick %@ \n btcPrivate %@\n btcpublickBase64 %@ \n btcPrivateBase64 %@\n btc_address %@ \n lamb_address %@",[[LambUtils shareInstance].currentUser.mnemonic componentsJoinedByString:@" "],[LambUtils shareInstance].currentUser.lambMnemonic.keychain.extendedPublicKey,[LambUtils shareInstance].currentUser.lambMnemonic.keychain.extendedPrivateKey ,[LambUtils shareInstance].currentUser.lambMnemonic.keychain.key.address.publicAddress.string,[LambUtils shareInstance].currentUser.publicKey,[LambUtils shareInstance].currentUser.privateKey,[LambUtils shareInstance].currentUser.publicKeyBase64,[LambUtils shareInstance].currentUser.privateKeyBase64,[[LambUtils shareInstance].currentUser.lambKeyChain.identifier hexString],[LambUtils shareInstance].currentUser.address);
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

+ (NSString *)signatureForHash:(NSString *)jsonString {
    
    return [[CBSecp256k1 compactSignData:BTCSHA256([jsonString dataUsingEncoding:NSUTF8StringEncoding]) withPrivateKey:[LambUtils shareInstance].currentUser.lambKeyChain.key.privateKey] base64EncodedString];

    
//    return [[CBSecp256k1 compactSignData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] withPrivateKey:[LambUtils shareInstance].currentUser.lambKeyChain.key.privateKey] base64EncodedString];
    
//    return [[[LambUtils shareInstance].currentUser.lambKeyChain.key signatureForMessage:jsonString] base64EncodedString];
    
//    return [[[LambUtils shareInstance].currentUser.lambKeyChain.key signatureForHash:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedString];
}

/// 按照字典的key排序，返回json的数据格式
+ (NSString *) dictionaryToJson:(NSDictionary *)dic{
    NSError *error = nil;
    NSData *jsonData ;
    NSString *jsonString;
    if (@available(iOS 11.0, *)) {
        jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingSortedKeys error:&error];
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        jsonString = [LambUtils jsonStringWithDict:dic ascend:@"YES"];
    }
    return jsonString;
}

/// 按照字典的key排序，返回json的数据格式
/// @param dict 要转换成
/// @param asc @"YES" 代表升序，@"NO" 降序
+(NSString*)jsonStringWithDict:(NSDictionary*)dict ascend:(NSString *)asc{
    NSArray*keys = [dict allKeys];
    if (keys.count==0) {
        return nil;
    }
    
    int flag=0;// 在拼接json的时候判断是不是字典来判断是不要双引号
    NSArray*sortedArray;
    NSString*str =@"{\"";// 拼接json的转换的结果
    
    // 自定义比较器来比较key的ASCII码
    sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//升序排序
    }];
    
    // 逐个取出key和value，然后拼接json
    for (int i=0; i<sortedArray.count; i++) {
        
        NSString *categoryId;
        
        if ([asc isEqualToString:@"YES"]) {// 升序排序
            categoryId = sortedArray[i];
        }else{ // 降序排序
            categoryId = sortedArray[sortedArray.count-1-i];
        }
        id value = [dict objectForKey:categoryId];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            flag=1;
            value = [LambUtils jsonStringWithDict:value ascend:asc];
        }
        
        // 拼接json串的分割符
        if([str length] !=2) {
            str = [str stringByAppendingString:@",\""];
        }
        // 对数组类型展开处理
        if([value isKindOfClass:[NSArray class]]){
            str = [str stringByAppendingFormat:@"%@\":[",categoryId];
            str = [LambUtils sortInner:value jsonString:str];
            // 因为在 处理完数组类型后，json已经拼接好，直接拼接下一个串
            continue;
        }
        
        if (flag==1) {
            str = [str stringByAppendingFormat:@"%@\":%@",categoryId,value];
            flag=0;
        }else{
            if(![value isKindOfClass:[NSString class]]){// 如果是number类型，value不需要加双引号
                // 如果是BOOl类型则转化为false和true
                Class c = [value class];
                NSString * s = [NSString stringWithFormat:@"%@", c];
                if([s isEqualToString:@"__NSCFBoolean"]){
                    
                    if ([value isEqualToNumber:@YES]) {
                        str = [str stringByAppendingFormat:@"%@\":%@",categoryId,@"true"];
                        
                    }else{
                        str = [str stringByAppendingFormat:@"%@\":%@",categoryId,@"false"];
                    }
                }else{
                    str = [str stringByAppendingFormat:@"%@\":%@",categoryId,value];
                }
            }else{
                str = [str stringByAppendingFormat:@"%@\":\"%@\"",categoryId,value];
            }
        }
    }
    str = [str stringByAppendingString:@"}"];
    NSLog(@"result json = %@", str);
    return str;
}

+(NSString *) sortInner:(NSArray *) array jsonString:(NSString *)json{
    NSString *string =@"";
    NSInteger location = 0;
    for (int i=0; i< array.count; i++) {
        
        if(i!=0&&i< array.count) {
            json = [json stringByAppendingString:@","];
        }
        
        id arr = [array objectAtIndex:i];
        if([arr isKindOfClass:[NSDictionary class]]){// 如果数组里包含字典，则对该字典递归排序
            location = i;
            string=[LambUtils jsonStringWithDict:arr ascend:@"YES"];
            json = [json stringByAppendingFormat:@"%@",string];
        }else{
            if([arr isKindOfClass:[NSString class]]){
                json = [json stringByAppendingFormat:@"\"%@\"",arr];
            }else{
                // 如果是BOOl类型则转化为false和true
                Class c = [arr class];
                NSString * s = [NSString stringWithFormat:@"%@", c];
                if([s isEqualToString:@"__NSCFBoolean"]){
                    
                    if ([arr isEqualToNumber:@YES]) {
                        json = [json stringByAppendingFormat:@"%@",@"true"];
                        
                    }else{
                        json = [json stringByAppendingFormat:@"%@",@"false"];
                    }
                }else{
                    json = [json stringByAppendingFormat:@"%@",arr];
                }
                
            }
        }
    }
    
    json = [json stringByAppendingString:@"]"];
    return json;
}

- (LambWalltBackModel *)backModel {
    LambWalltBackModel *backModel = [LambWalltBackModel new];
    if ([LambUtils shareInstance].currentUser) {
        backModel.name = [LambUtils shareInstance].currentUser.name;
        backModel.address = [LambUtils shareInstance].currentUser.address;
        backModel.publicKey = [LambUtils shareInstance].currentUser.publicKey;
        backModel.privateKey = [LambUtils shareInstance].currentUser.privateKey;
    }
    return backModel;
}

+ (NSString *) nodeAddress {
    
    if (![LambUtils shareInstance].currentUser.lambNodeAddress) {
        [LambUtils shareInstance].currentUser.lambNodeAddress = [LambUtils getLambdaAddress:[LambUtils shareInstance].currentUser.lambKeyChain.identifier prefix:@"lambdavaloper"];
    }
    return [LambUtils shareInstance].currentUser.lambNodeAddress;
}


@end
