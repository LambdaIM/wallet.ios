//
//  KBWithdrawRewardSubVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBWithdrawRewardSubVC.h"
#import "SXCodeTool.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface KBWithdrawRewardSubVC ()

@property (nonatomic, strong) NSMutableArray *nodeListArray;

@end

@implementation KBWithdrawRewardSubVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLab1 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"提取数额") font:[UIFont pFSize:18] textColor:[UIColor blackColor]];
        [self.view addSubview: lab];
        [lab sizeToFit];
        lab.top = 10;
        lab.left = kLeftRightM;
        lab;
    });
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftRightM, tipLab1.bottom+8, kScreenW-2*kLeftRightM - 60, 80)];
    [self.view addSubview: tf];
    tf.text = self.m_nodeRevenue ? @"0" : [LambNodeManager manager].canWinCoinArray.count > 0 ? [[[LambNodeManager manager].canWinCoinArray firstObject].amount getNumber:@"6"] : @"0";
    tf.font = [UIFont pFBlodSize:30];

    tf.userInteractionEnabled = NO;
    
    UILabel *tipLab2 = ({
        UILabel *lab =
        [UILabel text:@"LAMB" font:[UIFont pFSize:18] textColor:[UIColor blackColor]];
        [self.view addSubview: lab];
        [lab sizeToFit];
        lab.centerY = tf.centerY + 5;
        lab.right = kScreenW - kLeftRightM;
        lab;
    });
    
    UIView *line = [UIView new];
    line.backgroundColor = @"#B0B0B0".hexColor;
    [self.view addSubview: line];
    line.left = tf.left;
    line.top = tf.bottom;
    line.width = kScreenW - 2 * kLeftRightM;
    line.height = .5;
    
    UIView *tempV = nil;
    if (self.m_nodeRevenue) {
        tempV = line;
    } else {
        UILabel *tipLab3 = ({
            UILabel *lab =
            [UILabel text: ASLocalizedString(@"*一次只能从5个验证节点中提取奖励") font:[UIFont pFSize:14] textColor:@"ED204E".hexColor];
            [self.view addSubview: lab];
            [lab sizeToFit];
            lab.top = line.bottom + 10;
            lab.left = line.left;
            lab.width = line.width;
            [lab sizeToFit];
            lab;
        });
        tempV = tipLab3;
    }
    
    
    UIButton *btn = [UIButton btn];
    btn.normalTitle = ASLocalizedString(@"确认提取");
    [self.view addSubview: btn];
    CGFloat btnX = 60;
    btn.frame = CGRectMake(btnX, tempV.bottom + 80, kScreenW-2*btnX, 50);
    btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [btn addCorner];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        if (!self.m_nodeRevenue && [LambNodeManager manager].canWinCoinArray.count > 0) {
            [self getLambGas];
        }else{
            if (self.m_nodeRevenue) {
                
            }else{
                [ASHUD showHudTipStr:ASLocalizedString(@"暂无收益可提取")];
            }
        }
    }];
}

- (void) getLambGas{

    kWeakSelf(weakSelf)
    
    // 获取节点信息
    [LambNetManager GET:HTTP_Get_chain_details parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            ASNodeInfoModel *infoModel = [ASNodeInfoModel yy_modelWithDictionary:responseObject];
            [LambNodeManager manager].currentNodeInfo = infoModel;
            
            NSLog(@"111111111");

            // 获取资产信息
            [LambNetManager GET:JoinParam(USER_Get_Auth, [LambUtils shareInstance].currentUser.address) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    ASAssertModel *nodeDetail = [ASAssertModel yy_modelWithDictionary:responseObject];
                    [LambNodeManager manager].assertModel = nodeDetail;

                    NSLog(@"2222222222");
                    
                        // 获取 Gas
                        __block ASSendTBBTextGasModel *gasModel = [[ASSendTBBTextGasModel alloc]init];
                        gasModel.base_req.sequence = [LambNodeManager manager].assertModel.value.sequence;
                        gasModel.base_req.account_number = [LambNodeManager manager].assertModel.value.account_number;
                        gasModel.base_req.memo = @"";
                        gasModel.base_req.chain_id = [LambNodeManager manager].currentNodeInfo.network;
                        
                        NSString *gasString = [gasModel modelToJSONObject];
                        NSLog(@"gas:%@",gasString);

                        // 获取Gas 费用
                        [LambNetManager POST:JoinParam(getHTTP_Get_transaction_Gas, [LambUtils shareInstance].currentUser.address) parameters:gasString showHud:YES success:^(id  _Nonnull responseObject) {
                            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                
                                NSString *gasString = [NSString stringWithFormat:@"%.0f",[[responseObject objectForKey:@"gas_estimate"] doubleValue] * 1.2];
                                // 获取节点收益
                                [weakSelf getUtbbData:[LambUtils shareInstance].currentUser.address Complain:^(bool finish) {
                                    if (finish) {
                                        NSLog(@"%@",self.nodeListArray);
                                    }
                                }];
                                
//                                // 签名消息体
//                                weakSelf.signModel.chain_id = gasModel.base_req.chain_id;
//                                weakSelf.signModel.account_number = gasModel.base_req.account_number;
//                                weakSelf.signModel.sequence = gasModel.base_req.sequence;
//                                weakSelf.signModel.memo = gasModel.base_req.memo;
//                                weakSelf.signModel.fee.amount = amountArray;
//                                weakSelf.signModel.fee.gas = gasString;
//                                // gas价格 写死
//                                ASSendAmountModel *amountModel = [weakSelf.signModel.fee.amount firstObject];
//                                amountModel.amount = @"101745";
//
//                                ASSendAmountModel *msgAmountModel = [[ASSendAmountModel alloc]init];
//                                msgAmountModel.denom = amountModel.denom;
//                                msgAmountModel.amount = [[self.amountField.text stringByTrim] requestShowNumber:@"0"];
//
//                                ASSendMsgModel *msgModel = [[ASSendMsgModel alloc] init];
//                                msgModel.value.to_address = gasModel.to_address;
//                                msgModel.value.amount = [NSArray arrayWithObject:msgAmountModel];
//                                NSArray *msgArray = [NSArray arrayWithObject:msgModel];
//                                weakSelf.signModel.msgs = msgArray;
//
//                                weakSelf.sendModel.tx.fee = weakSelf.signModel.fee;
//
//                                // 发送消息体
//                                weakSelf.sendModel.tx.memo = weakSelf.signModel.memo;
//                                weakSelf.sendModel.tx.msg = weakSelf.signModel.msgs;
//
//                                __block ASSendSignaturesModel *signAtures = [[ASSendSignaturesModel alloc]init];
//
//                                NSArray *signArray = [NSArray arrayWithObject:signAtures];
//                                weakSelf.sendModel.tx.signatures = signArray;
//
//                                // 签名的数据
//                                NSDictionary *signDic = [weakSelf.signModel modelToJSONObject];
//
//                                NSString *signString = [LambUtils dictionaryToJson:signDic];
//
//                                NSMutableString * str3 = [[NSMutableString alloc]initWithString:signString];
//
//                                [str3 replaceOccurrencesOfString:@"\\" withString:@"" options:1 range:NSMakeRange(0, str3.length)];
//
//                                NSString *signModelString = [LambUtils signatureForHash:str3];
//
//                                signAtures.signature = signModelString;
//
//                                __block id requestObj = [weakSelf.sendModel modelToDictionary];
//
//                                NSLog(@"发送交易签名后的数据： %@ \n 签名字符串： %@ \n 发送请求：%@",signModelString,str3,[requestObj yy_modelToJSONString]);
//                                NSLog(@"33333333");
//
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    ASVerifyPasswordView *passwrodView = [ASVerifyPasswordView factoryWCSGoogleVerifyView];
//
//                                    [passwrodView showWihtType:@"LAMB" gas:weakSelf.sendModel.tx.fee.gas];
//                                    passwrodView.confirmPassword = ^(BOOL state) {
//                                        if (state) {
//                                            // 发送交易请求
//                                            [weakSelf extracted:requestObj];
//                                        }
//                                    };
//                                });
                            }
                        } failure:^(NSError * _Nonnull error) {
                            [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
                        }];
                }else{
                    [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
                }
            } failure:^(NSError * _Nonnull error) {
                [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
    }];
}


// 获取质押Tbb节点
- (void) getUtbbData:(NSString *) lambAddressString Complain:(void(^)(bool finish)) complain{
    
    kWeakSelf(weakSelf)
    [LambNodeManager manager].uttb = @"0";
    [LambNetManager GET:JoinParam(getHTTP_get_zhiya_producer, lambAddressString) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *array = [NSArray yy_modelArrayWithClass:[ASNodeListModel class] json:responseObject];
            [weakSelf.nodeListArray removeAllObjects];
            if (array) {
                [weakSelf.nodeListArray addObjectsFromArray:array];
            }
            __block NSInteger i = 0;
            for (__block ASNodeListModel *node in weakSelf.nodeListArray) {
                [weakSelf getNode:node.validator_address winLambDataComplain:^(ASProposalValueAmountModel *amountModel) {
                    node.winLamb = amountModel.amount;
                    i ++ ;
                    if (i == weakSelf.nodeListArray.count) {
                        
                        NSArray *tempArray = [weakSelf.nodeListArray sortedArrayUsingComparator:^NSComparisonResult(ASNodeListModel *obj1, ASNodeListModel *obj2) {
                            return [obj1.winLamb longLongValue] > [obj2.winLamb longLongValue];
                        }];
                        
                        [weakSelf.nodeListArray removeAllObjects];
                        [weakSelf.nodeListArray addObjectsFromArray:tempArray];
                        complain(YES);
                    }
                }];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        complain(NO);
    }];
}

/// 获取lamb奖励
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

- (NSMutableArray *)nodeListArray {
    if (!_nodeListArray) {
        _nodeListArray = [NSMutableArray array];
    }
    return _nodeListArray;
}

@end
