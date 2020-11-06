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

@interface ASFundVC ()<UITableViewDelegate,UITableViewDataSource,ASFundHeadViewDelegate>

@property (nonatomic,copy) NSString *lambdaAddress;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ASFundVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lambdaAddress = @"lambdaasjd...lkadlf";
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
//    self.title = @"资产";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.titleLabel.font = [UIFont pFBlodSize:16];
    [leftBtn setTitle:@"lambdaasjd...lkadlf" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed: @"home_copy"] forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:16];
    leftBtn.frame = CGRectMake(0, 0, 150, 30);
    [leftBtn addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftMenuItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[leftMenuItem];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed: @"home_scan"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn addTarget:self action:@selector(scanActioin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightMenuItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightMenuItem];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark -  UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ASFundHeadView *headView = [[ASFundHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
    headView.delegate = self;
    return headView;
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
    return cell;
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
    
    ASScanViewController *scanVc = [[ASScanViewController alloc] initWithQrType:ASScanTypeAll onFinish:^(NSString *result, NSError *error) {
        if (error) {
        }else{
        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
}

#pragma mark -  ASFundHeadViewDelegate
// 转账
- (void)transfer {
    pushToDestinationController(self, ASFundTransferVC);
}
// 收款
- (void)collection {
    pushToDestinationController(self, ASFundCollectioinVC)
}
// 兑换
- (void)exchange {
    pushToDestinationController(self, ASFundExchangeVC)
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
