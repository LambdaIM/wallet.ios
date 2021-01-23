//
//  ASNodeModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/13.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASNodeProtocolInfoModel : ASModel

@property (nonatomic, copy) NSString *p2p;
@property (nonatomic, copy) NSString *block;
@property (nonatomic, copy) NSString *app;

@end

@interface ASNodeOtherInfoModel : ASModel

@property (nonatomic, copy) NSString *tx_index;
@property (nonatomic, copy) NSString *rpc_address;

@end
// 节点信息模型
@interface ASNodeInfoModel : ASModel

@property (nonatomic, copy) NSString *nodeId;
@property (nonatomic, copy) NSString *listen_addr;
@property (nonatomic, copy) NSString *network;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *channels;
@property (nonatomic, copy) NSString *moniker;

@property (nonatomic, strong) ASNodeOtherInfoModel *other;
@property (nonatomic, strong) ASNodeProtocolInfoModel *protocol_version;

@end

@interface ASNodeModel : ASModel<NSCoding>

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, assign) BOOL select;

- (instancetype) initWithBaseUrl:(NSString *) baseUrl port:(NSString *)port nodeName:(NSString *)nodeName select:(BOOL) select;;

@end

NS_ASSUME_NONNULL_END
