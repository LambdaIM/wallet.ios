//
//  ASFundVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/5.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundVC.h"
#import "ASScanViewController.h"
#import "UIButton+ImageTitleStyle.h"
#import "ASHUD.h"
#import "ASFundHeadView.h"
#import "SXCodeTool.h"
#import "ASFundCell.h"
#import "ASConst.h"
#import "UIView+Ex.h"
#import "ASFundTransferVC.h"
#import "ASFundCollectioinVC.h"
#import "ASFundExchangeVC.h"
#import "ASFundCoinDetailVC.h"

#import "ASAssertModel.h"
#import "ASQRModel.h"
#import <MJRefresh/MJRefresh.h>

@interface ASFundVC ()<UITableViewDelegate,UITableViewDataSource,ASFundHeadViewDelegate>

@property (nonatomic, copy) NSString *lambdaAddress;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ASFundHeadView *headView;    //
@property (nonatomic, strong) ASAssertModel *assertModel; // 张虎模型
@property (nonatomic, strong) UIButton *leftNavBtn;    //

@end

@implementation ASFundVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lambdaAddress = [LambUtils shareInstance].currentUser.address;
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
//    self.title = @"资产";
    self.navigationItem.title = @"";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftNavBtn = leftBtn;
    leftBtn.titleLabel.font = [UIFont pFBlodSize:16];
    [leftBtn setTitle:[NSString stringWithFormat:@"%@...%@",[self.lambdaAddress substringToIndex:10],[self.lambdaAddress substringFromIndex:self.lambdaAddress.length - 6]] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed: @"home_copy"] forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:16];
    leftBtn.frame = CGRectMake(0, 0, 200, 30);
    [leftBtn addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftMenuItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[leftMenuItem];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed: @"home_scan"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn addTarget:self action:@selector(scanActioin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightMenuItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightMenuItem];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kll_Status_NavBarHeight - kll_Tabbar_SafeBottomHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.view addSubview:_tableView];
    
    [self setupRefreshHeader];
}

#pragma mark -  UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.assertModel) {
        return self.assertModel.value.coins.count;
    }else{
        return 0;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.assertModel) {
        BOOL haveLamb = NO;
        for (ASProposalValueAmountModel *model in self.assertModel.value.coins) {
            if ([model.denom isEqualToString:@"ulamb"]) {
                [self.headView setLambBalance:[model.amount getShowNumber:@"6"]];
                haveLamb = YES;
                break;
            }
        }
        if (!haveLamb) {
            [self.headView setLambBalance:@"0"];
        }
    }else{
        [self.headView setLambBalance:@"0"];
    }
    return self.headView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 350;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(kLeftRightM, 0, kScreenW - 2 * kLeftRightM, 30)];
    centerView.backgroundColor = [UIColor whiteColor];
    [centerView addCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:10];
    [bgView addSubview:centerView];
    return bgView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASFundCell *cell = [ASFundCell cellFromTable:tableView];
    if (self.assertModel) {
        ASProposalValueAmountModel *model = [self.assertModel.value.coins objectAtIndex:indexPath.row];
        NSString *coinName = [[[model.denom componentsSeparatedByString:@"u"] lastObject] uppercaseString];
        
        [cell configCellWithCoinName:coinName balance:[NSString stringWithFormat:@"%@ %@",[model.amount getShowNumber:@"6"],coinName]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    
//    if ([[self.dataArray[indexPath.row] firstObject] isEqualToString:@"XXB"]) {
//        ASFundCoinDetailVC *detailVC = [ASFundCoinDetailVC new];
//        [self.navigationController push:detailVC];
//    }
}

- (ASFundHeadView *)headView {
    if (!_headView) {
        _headView = [[ASFundHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
        _headView.delegate = self;
    }
    return _headView;
}

- (void)setupRefreshHeader
{
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self loadData];
    }];
}


- (void)endRefresh
{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
}

/// 拷贝
- (void)copyAction {
    
    // 复制地址
    NSString *str = self.lambdaAddress;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =str;
    
    [ASHUD showHudTipStr:@"复制成功"];
}

/// 扫描二维码
- (void)scanActioin {
    kWeakSelf(weakSelf)
    [LambNodeManager manager].qrModel = nil;
    ASScanViewController *scanVc = [[ASScanViewController alloc] initWithQrType:ASScanTypeAll onFinish:^(NSString *result, NSError *error) {
        if (!error) {
            NSData *turnData = [result dataUsingEncoding:NSUTF8StringEncoding];
            id resultDic = [NSJSONSerialization JSONObjectWithData:turnData options:NSJSONReadingMutableContainers error:NULL];
            if ([resultDic isKindOfClass:[NSDictionary class]]) {
                ASQRModel *scmodel = [ASQRModel yy_modelWithDictionary:resultDic];
                if ([scmodel.address hasPrefix:@"lamb"]) {
                    [LambNodeManager manager].qrModel = scmodel;
                    pushToDestinationController(self, ASFundTransferVC);
                }else{
                    [ASHUD showHudTipStr:@"无法进行扫码转账"];;
                }
            }else{
                [ASHUD showHudTipStr:@"无法进行扫码转账"];
            }
        }else{
            [ASHUD showHudTipStr:@"无法进行扫码转账"];
        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
}

#pragma mark -  ASFundHeadViewDelegate
// 转账
- (void)transfer {
    if (self.assertModel) {
        [LambNodeManager manager].qrModel = nil;
        pushToDestinationController(self, ASFundTransferVC);
    }else{
        [ASHUD showHudTipStr:@"无法进行转账"];
    }
}
// 收款
- (void)collection {
    pushToDestinationController(self, ASFundCollectioinVC)
}
// 兑换
- (void)exchange {
//    pushToDestinationController(self, ASFundExchangeVC)
    [ASHUD showHudTipStr:@""];
}

- (void) loadData {
    
    kWeakSelf(weakSelf)
    [self getaAssertComplain:^(ASAssertModel *assertModel) {
        weakSelf.assertModel = assertModel;
        [weakSelf reloadUI];
    }];
}

// 获取资产详情
- (void) getaAssertComplain:(void(^)(ASAssertModel *assertModel)) complain{
    
    kWeakSelf(weakSelf)
    [LambNetManager GET:JoinParam(USER_Get_Auth, [LambUtils shareInstance].currentUser.address) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ASAssertModel *nodeDetail = [ASAssertModel yy_modelWithDictionary:responseObject];
            [LambNodeManager manager].assertModel = nodeDetail;
            complain(nodeDetail);
            [weakSelf endRefresh];
        }else{
            complain(nil);
            [weakSelf endRefresh];
        }
    } failure:^(NSError * _Nonnull error) {
        complain(nil);
        [weakSelf endRefresh];
    }];
}

- (void) reloadUI {
    
    [self.leftNavBtn setTitle:[NSString stringWithFormat:@"%@...%@",[self.lambdaAddress substringToIndex:10],[self.lambdaAddress substringFromIndex:self.lambdaAddress.length - 6]] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
