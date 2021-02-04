//
//  KBVerifyNodeDetailVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBVerifyNodeDetailVC.h"
#import "UIView+Ex.h"
#import "SXCodeTool.h"
#import "UIImage+Ex.h"
#import "KBPledgeVC.h"
#import "KBTransferPledgeVC.h"

@interface KBVerifyNodeDetailVC ()
@property(nonatomic, weak) UIScrollView *m_scroll;
@property(nonatomic, weak) UIButton *m_btn1;
@property(nonatomic, weak) UIButton *m_btn2;
@property(nonatomic, weak) UIButton *m_btn3;

@end

@implementation KBVerifyNodeDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [self getUtbbData:[LambUtils shareInstance].currentUser.address Complain:^(bool finish) {
        
    }];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = ASLocalizedString(@"验证节点详情");
    [self configData];
    UIScrollView *ms = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:ms];
    self.m_scroll = ms;
    ms.contentSize = CGSizeMake(kScreenW, kScreenH);
    NSArray<NSDictionary<NSString *, NSString *> *> *dicts =
    @[@{@"title": @"节点昵称", @"value": self.nodeDetail.descriptions.moniker},
      @{@"title": @"我的质押", @"value": @"0 TBB"},
      @{@"title":@"我的奖励", @"value": @"0 LAMB"},
      @{@"title": @"质押地址", @"value": self.nodeDetail.operator_address},

      @{@"title": @"简   介", @"value": self.nodeDetail.descriptions.details.length == 0 ? @" ":self.nodeDetail.descriptions.details},

      @{@"title": @"节点收益", @"value": [self.nodeDetail.commission.rate persentString]},
      @{@"title": @"最大收益", @"value": [self.nodeDetail.commission.max_rate persentString]},
      @{@"title": @"最大收益变化", @"value": [self.nodeDetail.commission.max_change_rate persentString]},
      @{@"title": @"投票权重", @"value": self.nodeDetail.persent == nil ? @"0%" : self.nodeDetail.persent},
    ];
    CGFloat leftM = 15;
    UIView *topV = [[UIView alloc] initWithFrame:CGRectMake(leftM, leftM, kScreenW-2*leftM, 220)];
    [ms addSubview: topV];
    topV.backgroundColor = [UIColor whiteColor];
    __block UILabel *lastLab = nil;
    [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *tipLab = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString([NSString stringWithFormat:@"%@%@", obj[@"title"], @"："]) font:[UIFont pFSize:14] textColor:[UIColor blackColor]];
            [topV addSubview: lab];
            if (idx == 0) {
                lab.top = 10;
            } else {
                lab.top = lastLab.bottom + 15;
            }
            lab.left = 15;
            lab;
        });
        
        [topV addSubview: tipLab];
        UILabel *valueLab = ({
            UILabel *lab =
            [UILabel text:obj[@"value"] font:[UIFont pFSize:14] textColor:[UIColor lightGrayColor]];
            lab.numberOfLines = 0;
            [topV addSubview: lab];
            lab.top = tipLab.top;
            lab.left = tipLab.right + 8;
            lab.width = topV.width - 15 - lab.left;
            [lab sizeToFit];
            lab;
        });
        valueLab.tag = 8000 + idx;
        if (valueLab.tag == 8001 ||valueLab.tag == 8002) {
            valueLab.numberOfLines = 1;
        }
        [topV addSubview: valueLab];
        lastLab = valueLab;
    }];
    
    topV.height = lastLab.bottom + 30;
    
    topV.layer.cornerRadius = 8;
    ms.contentSize = CGSizeMake(kScreenW, MAX(topV.bottom + 20, kScreenH));
    
    CGFloat svH = 50;
    CGFloat btnM = 10;
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-kll_Status_NavBarHeight - svH -kll_SafeBottomMargin, kScreenW, svH)];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomV];
    
    UIButton *btn1 = [UIButton btn];
    btn1.normalTitle = ASLocalizedString(@"取消质押");
    [bottomV addSubview: btn1];
    UIEdgeInsets btnInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    btn1.contentEdgeInsets = btnInsets;
    
    
    UIButton *btn2 = [UIButton btn];
    btn2.normalTitle = ASLocalizedString(@"转质押");
    [bottomV addSubview: btn2];
    btn2.contentEdgeInsets = btnInsets;
    
    UIButton *btn3 = [UIButton btn];
    btn3.normalTitle = ASLocalizedString(@"TBB质押挖矿");
    [bottomV addSubview: btn3];
    btn3.contentEdgeInsets = btnInsets;

    self.m_btn1 = btn1;
    [btn1 sizeToFit];
    [btn2 sizeToFit];
    [btn3 sizeToFit];
    self.m_btn2 = btn2;
    self.m_btn3 = btn3;
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    @weakify(self);
    [[btn1  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        KBPledgeVC *vc = [KBPledgeVC new];
        vc.m_cancel = YES;
        vc.nodeDetailModel = self.nodeDetail;
        [self push:vc];
    }];
    [[btn2  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        KBTransferPledgeVC *vc = [KBTransferPledgeVC new];
        vc.nodeDetailModel = self.nodeDetail;
        [self push:vc];
    }];
    [[btn3  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        if (self.nodeDetail.status == 2) {
            KBPledgeVC *vc = [KBPledgeVC new];
            vc.nodeDetailModel = self.nodeDetail;
            [self push:vc];
        }
    }];
    
    [btn1 centerYEqualSuper];
    btn1.left = (bottomV.width -  btn1.width - btn2.width - btn3.width - 2*btnM) * 0.5;
    if (btn1.left < 0) {
        NSLog(@"---%@---",@"f");
    }
    btn2.left = btn1.right + btnM;
    btn2.centerY = btn1.centerY;
    btn3.left = btn2.right + btnM;
    btn3.centerY = btn2.centerY;
    if (kll_SafeBottomMargin > 0) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-kll_Status_NavBarHeight - kll_SafeBottomMargin, kScreenW, kll_SafeBottomMargin)];
        v.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:v];

    }
    [bottomV sizeToFit];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.m_scroll.frame = self.view.bounds;
    self.m_scroll.height = kScreenH - kll_Status_NavBarHeight - 50 - kll_SafeBottomMargin;
    [@[self.m_btn1, self.m_btn2, self.m_btn3] enumerateObjectsUsingBlock:^(UIButton*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!btn.normalBackgroundImage) {
            btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
            [btn addCorners:UIRectCornerAllCorners radius:btn.height*0.5];
        }
    }];
}

- (void) reloadData{
    UILabel *lockTbbLab = [self.view viewWithTag:8000 + 1];
    UILabel *winLabmLab = [self.view viewWithTag:8000 + 2];
    lockTbbLab.text = [NSString stringWithFormat:@"%@ TBB",self.nodeDetail.utbb.length > 0 ? [self.nodeDetail.utbb getShowNumber:@"6"]:@"0"];
    winLabmLab.text = [NSString stringWithFormat:@"%@ LAMB",self.nodeDetail.winLamb.length > 0 ? [self.nodeDetail.winLamb getShowNumber:@"6"]:@"0"];
    [lockTbbLab sizeToFit];
    [winLabmLab sizeToFit];
}

// 获取节点详情
- (void) getNodeDetailData:(NSString *) nodeAddress Complain:(void(^)(ASNodeListModel *nodeDetail)) complain{
    kWeakSelf(weakSelf)
    
    [LambNetManager GET:JoinParam(HTTP_Get_producers_details, nodeAddress) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ASNodeListModel *nodeDetail = [ASNodeListModel yy_modelWithDictionary:responseObject];
            weakSelf.nodeDetail.tokens = nodeDetail.tokens;
            weakSelf.nodeDetail.delegator_shares = nodeDetail.delegator_shares;
            complain(nodeDetail);
        }else{
            complain(nil);
        }
    } failure:^(NSError * _Nonnull error) {
        complain(nil);
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
                
                if ([node.validator_address isEqualToString:weakSelf.nodeDetail.operator_address]) {
                    [weakSelf getWinLambDataComplain:^(bool finish) {
                                            
                    }];
                    [weakSelf getNodeDetailData:weakSelf.nodeDetail.operator_address Complain:^(ASNodeListModel *nodeDetail) {
                        weakSelf.nodeDetail.utbb = [NSString stringWithFormat:@"%f",[[LambNodeManager manager].uttb doubleValue] + [node.shares doubleValue] * [weakSelf.nodeDetail.tokens doubleValue] / [weakSelf.nodeDetail.delegator_shares doubleValue]];
                        [weakSelf reloadData];
                    }];
                }
            }
        }
        complain(YES);
    } failure:^(NSError * _Nonnull error) {
        complain(NO);
    }];
}

// 获取lamb奖励
- (void) getWinLambDataComplain:(void(^)(bool finish)) complain{
    
    kWeakSelf(weakSelf)
    [LambNetManager GET:JoinParams(getHTTP_Get_for_producers_award_validatorAddr, [LambUtils shareInstance].currentUser.address,self.nodeDetail.operator_address) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *objs = [NSArray yy_modelArrayWithClass:[ASProposalValueAmountModel class] json:responseObject];
            ASProposalValueAmountModel *model = [objs firstObject];
            weakSelf.nodeDetail.winLamb = model.amount;
            [weakSelf reloadData];
            complain(YES);
        }else{
            complain(NO);
        }
    } failure:^(NSError * _Nonnull error) {
        complain(NO);
    }];
}

- (void) configData {
    
    if (!self.nodeDetail.persent) {
        for (ASNodeListModel *model in [LambNodeManager manager].nodelArray) {
            if ([model.operator_address isEqualToString:self.nodeDetail.operator_address]) {
                self.nodeDetail.persent = model.persent;
                break;
            }
        }
    }
}

@end
