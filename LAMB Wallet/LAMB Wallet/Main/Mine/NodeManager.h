//
//  NodeManager.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASNodeModel.h"

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
/// 切换验证节点
/// @param type 节点类型
/// @param url 节点地址
/// @param port 端口号
- (void) configNodeType:(ASNodeType)type baseUrl:(NSString *) url prot:(NSString *) port;

+ (NSArray *) loadNodes;

- (void) configNode:(ASNodeModel *) node;

+ (void) addNode:(ASNodeModel *) node;

+ (void) addNodes:(NSArray *) nodes;
@end

NS_ASSUME_NONNULL_END
