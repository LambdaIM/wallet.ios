//
//  LambNodeManager.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASNodeModel.h"
#import "ASProposalModel.h"
#import "ASNodeListModel.h"
#import "ASQRModel.h"
#import "ASAssertModel.h"

typedef NS_ENUM(NSInteger, ASNodeType)
{
    ASNodeTypeMain,
    ASNodeTypeTest,
    ASNodeTypeCustom
};
NS_ASSUME_NONNULL_BEGIN
/// 节点管理
@interface LambNodeManager : NSObject

@property(nonatomic,copy) NSString *bonded_tokens;// 全网质押toeken数量
@property(nonatomic,copy) NSString *not_bonded_tokens;// 全网未质押token数量
@property(nonatomic,strong) NSArray <ASProposalValueAmountModel *>*canWinCoinArray;// lamb收益
@property(nonatomic,strong) NSArray <ASNodeListModel *>*nodelArray;// 所有的节点
@property(nonatomic,copy) NSString *uttb;// 总的质押tbb数量  shares*(tokens/delegator_shares)
@property(nonatomic,strong) ASQRModel *qrModel;// 扫描二维码模型
@property(nonatomic,assign) ASNodeType type;
@property(nonatomic,strong) ASAssertModel *assertModel;// 资产模型
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
