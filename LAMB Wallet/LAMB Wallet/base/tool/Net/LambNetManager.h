//
//  LambNetManager.h
//  LAMB Wallet
//
//  Created by fei on 2020/11/19.
//  Copyright © 2020 fei. All rights reserved.
//  网络请求

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h" 
NS_ASSUME_NONNULL_BEGIN

@interface LambNetManager : NSObject
 
/**
 GET数据请求

 @param urlString  URL
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)GET:(NSString *)urlString parameters:(id)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure;

/**
 POST数据请求

 @param urlString  URL
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;

/**
 单张图片或者多张图片上传

 @param urlString URL
 @param parameters 参数
 @param imageArray 图片数组 @[UIImage]
 @param imageKeys 上传图片对应的 key
 @param successs 成功回调
 @param failure 失败回调
 */
+ (void)uploadMorePost:(NSString *)urlString parameters:(id)parameters UploadImage:(NSArray *)imageArray ImageKey:(NSArray *)imageKeys success:(void (^)(id responseObject))successs failure:(void (^)(NSError *error))failure;

/**
 实时监测网络变化

 @param netStatus 当前网络状态
 */
+ (void)ReachabilityStatus:(void (^)(id string))netStatus;

@end

NS_ASSUME_NONNULL_END
