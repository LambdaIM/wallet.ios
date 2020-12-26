//
//  MiningVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "MiningVC.h"
#import "MiningCell.h"
#import "SXCodeTool.h"
#import "MiningHeaderView.h"
#import "UIView+Ex.h"
#import "KBVerifyNodeDetailVC.h"
#import "ASNodeListModel.h"
@import MJRefresh;

@interface MiningVC ()
{
    BOOL requested;// 第一次请求
}

@property(nonatomic, strong) MiningHeaderView *header;

@end

@implementation MiningVC

- (void)viewWillAppear:(BOOL)animated {
    
    if (!requested) {
        [self loadNodeListData:nil];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUIRealTime];
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.rowHeight = 70;
    self.table.mj_footer.hidden = YES;
    [self.table registerXibCell:[MiningCell class]];
    
    _header =
    [[MiningHeaderView alloc] initWithFrame:CGRectMake(15, 0, kScreenW-2*15, 260)];
    self.table.tableHeaderView = self.header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MiningCell *cell = [MiningCell cellFromTable:tableView];
    if (self.datas.count) {
        cell.model = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(MiningCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self tableView:tableView numberOfRowsInSection:0]-1){
        [cell.m_contentView addCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) radius:8];
    } else {
        
        cell.m_contentView.layer.mask = nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KBVerifyNodeDetailVC *detailVC = [KBVerifyNodeDetailVC new];
    detailVC.nodeDetail = [self.datas objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)loadDataAtPage:(NSInteger)page {
    requested = YES;
    [self loadNodeListData:nil];
}

- (void)loadNodeListData:(NSString *) stasus{
    
    kWeakSelf(weakSelf)
    // 获取全网质押总量
    [LambNetManager GET:HTTP_Get_chain_all_zhiya_token parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [LambNodeManager manager].bonded_tokens = [responseObject objectForKey:@"bonded_tokens"];
            [LambNodeManager manager].not_bonded_tokens = [responseObject objectForKey:@"not_bonded_tokens"];
            // 获取可用节点
            [LambNetManager GET:JoinParam(HTTP_Get_producers, @"bonded") parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSArray class]]) {
                    [weakSelf receivedDicts:responseObject atPage:1 resPageNum:@"1" resPageSize:@1000 objClass:[ASNodeListModel class]];
                }
                // 获取解绑中节点
                [weakSelf endRefresh];
                [LambNetManager GET:JoinParam(HTTP_Get_producers, @"unbonding") parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
                    if ([responseObject isKindOfClass:[NSArray class]]) {
                        [weakSelf receivedDicts:responseObject atPage:1 resPageNum:@"2" resPageSize:@1000 objClass:[ASNodeListModel class]];
                    }
                    [weakSelf endRefresh];
                    // 获取解绑节点
                    [LambNetManager GET:JoinParam(HTTP_Get_producers, @"unbonded") parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
                        if ([responseObject isKindOfClass:[NSArray class]]) {
                            [weakSelf receivedDicts:responseObject atPage:1 resPageNum:@"3" resPageSize:@1000 objClass:[ASNodeListModel class]];
                        }
                        [weakSelf endRefresh];
                    } failure:^(NSError * _Nonnull error) {
                        [weakSelf endRefresh];
                    }];
                } failure:^(NSError * _Nonnull error) {
                    // 获取解绑节点
                    [LambNetManager GET:JoinParam(HTTP_Get_producers, @"unbonded") parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
                        if ([responseObject isKindOfClass:[NSArray class]]) {
                            [weakSelf receivedDicts:responseObject atPage:1 resPageNum:@"3" resPageSize:@1000 objClass:[ASNodeListModel class]];
                        }
                        [weakSelf endRefresh];
                    } failure:^(NSError * _Nonnull error) {
                        [weakSelf endRefresh];
                    }];
                    [weakSelf endRefresh];
                }];
            } failure:^(NSError * _Nonnull error) {
                [weakSelf endRefresh];
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [weakSelf endRefresh];
    }];
    // 获取lamb 奖励
    [self getWinLambDataComplain:^(bool finish) {
        if (finish) {
            weakSelf.header.winLambString = [[[LambNodeManager manager].canWinCoinArray firstObject] amount];
            weakSelf.table.tableHeaderView = weakSelf.header;
            [weakSelf.table reloadData];
        }
        // 获取质押tbb 数量
        [weakSelf getUtbbData:lambAddress Complain:^(bool finish) {
                
        }];
    }];
    
}

// 获取lamb奖励
- (void) getWinLambDataComplain:(void(^)(bool finish)) complain{
    
    [LambNetManager GET:JoinParam(getHTTP_Get_for_producers_award, lambAddress) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *objs = [NSArray yy_modelArrayWithClass:[ASProposalValueAmountModel class] json:responseObject];
            [LambNodeManager manager].canWinCoinArray = objs;
        }
        complain(YES);
    } failure:^(NSError * _Nonnull error) {
        complain(NO);
    }];
}

// 获取质押Tbb节点
- (void) getUtbbData:(NSString *) lambAddressString Complain:(void(^)(bool finish)) complain{
    
    kWeakSelf(weakSelf)
    [LambNodeManager manager].uttb = @"0";
    [LambNetManager GET:JoinParam(getHTTP_get_zhiya_producer, lambAddressString) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *objs = [NSArray yy_modelArrayWithClass:[ASNodeListModel class] json:responseObject];
            for (ASNodeListModel *node in objs) {
                [weakSelf getNodeDetailData:node.validator_address Complain:^(ASNodeListModel *nodeDetail) {
                    
                    [LambNodeManager manager].uttb = [NSString stringWithFormat:@"%f",[[LambNodeManager manager].uttb doubleValue] + [node.shares doubleValue] * [nodeDetail.tokens doubleValue] / [nodeDetail.delegator_shares doubleValue]] ;
                    weakSelf.header.utbbString = [LambNodeManager manager].uttb;
                    weakSelf.table.tableHeaderView = weakSelf.header;
                    [weakSelf.table reloadData];
                }];
            }
        }
        complain(YES);
    } failure:^(NSError * _Nonnull error) {
        complain(NO);
    }];
}

// 获取节点详情
- (void) getNodeDetailData:(NSString *) nodeAddress Complain:(void(^)(ASNodeListModel *nodeDetail)) complain{
    [LambNetManager GET:JoinParam(HTTP_Get_producers_details, nodeAddress) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ASNodeListModel *nodeDetail = [ASNodeListModel yy_modelWithDictionary:responseObject];
            complain(nodeDetail);
        }else{
            complain(nil);
        }
    } failure:^(NSError * _Nonnull error) {
        complain(nil);
    }];
}


@end
