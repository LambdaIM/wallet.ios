//
//  LambNodeManager.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "LambNodeManager.h"


@implementation LambNodeManager
+ (instancetype)manager
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)configNodeType:(ASNodeType)type baseUrl:(NSString *)url prot:(NSString *)port {
    
    _type = type;
    switch (type) {
        case ASNodeTypeMain:
            [[LambNetManager shareInstance] setBaseUrl:RELEASEBASEURL];
            break;
        case ASNodeTypeTest:
            [[LambNetManager shareInstance] setBaseUrl:DEBUGBASEURL];
            break;
        case ASNodeTypeCustom:
            [[LambNetManager shareInstance] setBaseUrl:[NSString stringWithFormat:@"%@:%@",url,port]];
            break;
    }
}
+ (NSArray *)loadNodes {
    
    NSUserDefaults *defalult = [NSUserDefaults standardUserDefaults];
    NSArray * dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:kLOCALNODES];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    if (!dataArray) {
        ASNodeModel *mainNode =
        [[ASNodeModel alloc]initWithBaseUrl:[[RELEASEBASEURL componentsSeparatedByString:@":"] firstObject] port:[[RELEASEBASEURL componentsSeparatedByString:@":"] lastObject] nodeName:ASLocalizedString(@"主网默认节点") select:YES];
        [LambNodeManager addNode:mainNode];
        ASNodeModel *testNode = [[ASNodeModel alloc]initWithBaseUrl:[[DEBUGBASEURL componentsSeparatedByString:@":"] firstObject] port:[[DEBUGBASEURL componentsSeparatedByString:@":"] lastObject]  nodeName:ASLocalizedString(@"测试网默认节点") select:NO];
        [mutableArray addObjectsFromArray:@[mainNode,testNode]];
        [LambNodeManager addNodes:mutableArray];
    }else{
        for (NSData *goodsData in dataArray)
        {
            ASNodeModel  *goods = [NSKeyedUnarchiver unarchiveObjectWithData:goodsData];
            [mutableArray addObject:goods];
        }
    }
    return mutableArray;
}


+ (void)addNode:(ASNodeModel *) node{
    NSUserDefaults *defalult = [NSUserDefaults standardUserDefaults];
    NSArray *nodes = [defalult objectForKey:kLOCALNODES];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:nodes];
    
    if (node) {
        NSData *goodsEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:node];
        [tempArray addObject:goodsEncodedObject];
        [defalult removeObjectForKey:kLOCALNODES];
        [defalult setObject:tempArray forKey:kLOCALNODES];
    }
}

+ (void) addNodes:(NSArray *) nodes {
    NSUserDefaults *defalult = [NSUserDefaults standardUserDefaults];
    [defalult removeObjectForKey:kLOCALNODES];
    if (nodes) {
        [LambNodeManager saveSortArrayData:nodes];
    }
}

- (void)configNode:(ASNodeModel *)node {
    if (node) {
        [[LambNetManager shareInstance] setBaseUrl:[NSString stringWithFormat:@"%@:%@",node.baseUrl,node.port]];
        [LambNodeManager manager].nodeWinInfo = nil; // 节点收益
        [LambNodeManager manager].canWinCoinArray = nil;// 自己的收益
    }
}

+ (void)saveSortArrayData:(NSArray *)array {
    
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:array.count];
    for (ASNodeModel *goodsObject in array) {
        NSData *goodsEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:goodsObject];
        [archiveArray addObject:goodsEncodedObject];
    }
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    [userData setObject:archiveArray forKey:kLOCALNODES];
}
@end
