//
//  KBStoragePledgeSubVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBStoragePledgeSubVC.h"
#import "KBVerifyNodeDetailVC.h"

#import "ASStorageCell.h"

#import "ASNodeListModel.h"

@import MJRefresh;
@interface KBStoragePledgeSubVC ()

@end

@implementation KBStoragePledgeSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.rowHeight = 70;
    self.table.mj_footer.hidden = YES;
    [self.table registerXibCell:[ASStorageCell class]];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASStorageCell *cell = [ASStorageCell cellFromTable:tableView];
    if (self.datas) {
        ASNodeListModel *model = [self.datas objectAtIndex:indexPath.row];
        cell.listModel = model;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KBVerifyNodeDetailVC *detailVC = [KBVerifyNodeDetailVC new];
    detailVC.nodeDetail = [self.datas objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)loadDataAtPage:(NSInteger)page {
    [self.datas removeAllObjects];
    NSString *requestString = self.bund ? getHTTP_get_zhiya_producer : getHTTP_get_zhiya_unbonding_producer;
    [self getUtbbData:[LambUtils shareInstance].currentUser.address state:requestString Complain:^(bool finish) {
        
    }];
}


// 获取质押Tbb节点
- (void) getUtbbData:(NSString *) lambAddressString state:(NSString *) state Complain:(void(^)(bool finish)) complain{
    
    kWeakSelf(weakSelf)
    [LambNodeManager manager].uttb = @"0";
    [LambNetManager GET:JoinParam(state, lambAddressString) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *objs = [NSArray yy_modelArrayWithClass:[ASNodeListModel class] json:responseObject];
            
            dispatch_queue_t queue = dispatch_queue_create("lambSerialQueue", DISPATCH_QUEUE_SERIAL);
            dispatch_sync(queue, ^{

                for (ASNodeListModel *node in objs) {
                    [weakSelf getNodeDetailData:node.validator_address Complain:^(ASNodeListModel *nodeDetail) {
                        if (nodeDetail) {
                            nodeDetail.utbb = node.shares;
                            dispatch_sync(queue, ^{
                                [weakSelf getNode:nodeDetail.operator_address winLambDataComplain:^(ASProposalValueAmountModel *amountModel) {
                                    if (amountModel) {
                                        nodeDetail.winLamb = amountModel.amount;
                                        [weakSelf.datas addObject:nodeDetail];
                                    }else{
                                        [weakSelf.table.mj_header endRefreshing];
                                    }
                                    if (weakSelf.datas.count == objs.count) {
                                        [weakSelf.table reloadData];
                                        [weakSelf.table.mj_header endRefreshing];
                                    }
                                }];
                            });
                        }else{
                            [weakSelf.table.mj_header endRefreshing];
                        }
                    }];
                }
            });
            if (!objs.count) {
                [weakSelf.table.mj_header endRefreshing];
                [weakSelf.table reloadData];
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

// 获取lamb奖励
- (void) getNode:(NSString *) nodeAddress winLambDataComplain:(void(^)(ASProposalValueAmountModel *amountModel)) complain{
    
    [LambNetManager GET:JoinParams(getHTTP_Get_for_producers_award_validatorAddr, [LambUtils shareInstance].currentUser.address,nodeAddress) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *objs = [NSArray yy_modelArrayWithClass:[ASProposalValueAmountModel class] json:responseObject];
            
            if (objs.count) {
                complain([objs firstObject]);
            }else{
                complain(nil);
            }
        }else{
            complain(nil);
        }
    } failure:^(NSError * _Nonnull error) {
        complain(nil);
    }];
}

@end
