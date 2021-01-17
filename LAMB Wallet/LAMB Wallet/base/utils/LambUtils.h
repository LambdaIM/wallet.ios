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

+ (instancetype) shareInstance;

/// 本地缓存用户
/// @param user userModel
+ (void) saveUserInfo:(ASUserModel *) user;
/// 根据用户名获取用户信息
/// @param name 用户名
+ (ASUserModel *) getUserInfoWithUserName:(NSString *) name;
/// 移除所有用户
+ (void) removeAllUser;

@end

NS_ASSUME_NONNULL_END
