//
//  LambUtils.h
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/9.
//  Copyright © 2021 fei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LambUtils : NSObject

@property (nonatomic,strong) ASUserModel *currentUser;

@property (nonatomic,strong) NSMutableArray *localUserNames;


+ (instancetype) shareInstance;

/// 本地缓存用户
/// @param user userModel
+ (void) saveUserInfo:(ASUserModel *) user;

/// 根据用户名获取用户信息
/// @param name 用户名
+ (ASUserModel *) getUserInfoWithUserName:(NSString *) name;

/// 移除所有用户
+ (void) removeAllUser;

/// 生成bech32 地址
/// @param data 地址nsdata
/// @param prefix 前缀
+ (NSString *) getLambdaAddress:(NSData *) data prefix:(NSString *) prefix;

/// 检测助记词是否正确
/// @param words 助记词数组
+ (NSString *) checkMnemonicWords:(NSArray *) words;

/// 退出登录
+ (void) logOut ;

/// 判断用户是否登录
+ (BOOL) userLogin;

/// 创建助记词类
/// @param words 助记词数组
+ (void) creatMnemonicWithWords:(NSArray *) words;

/// 给json 签名
/// @param jsonString json数据
+ (NSString *) signatureForHash:(NSString *)jsonString;


/// 按照字典的key排序，返回json的数据格式
+ (NSString *) dictionaryToJson:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
