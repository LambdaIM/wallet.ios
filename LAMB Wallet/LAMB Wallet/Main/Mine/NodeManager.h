//
//  NodeManager.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ASNodeType)
{
    ASNodeTypeMain,
    ASNodeTypeTest,
    ASNodeTypeCustom
};
NS_ASSUME_NONNULL_BEGIN
/// 节点管理
@interface NodeManager : NSObject
// TODO: 功能待实现
@property(nonatomic) ASNodeType type;
+ (instancetype)manager;
@end

NS_ASSUME_NONNULL_END
