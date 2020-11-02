//
//  MineVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "MineVC.h"
#import "ASSetVC.h"
#import "MineHeaderView.h"
#import "ASManageWalletVC.h"

@interface MineVC ()
@end

@implementation MineVC
-(UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.hideNav = YES;
    self.table.rowHeight = 55;
    self.table.tableHeaderView = [MineHeaderView view];
   
    self.datas = @[@{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"imgName": @"icon_wode_qianbao", @"title":ASLocalizedString(@"管理钱包"), @"sel":@"pushToManageWallet"},
                   @{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"imgName": @"icon_wode_jiaoyijilu", @"title":ASLocalizedString(@"交易记录"), @"sel":@"pushToTransactionRecord"},
                   @{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"imgName": @"icon_wode_tian", @"title":ASLocalizedString(@"提案"), @"sel":@"pushToProposal"},
                   @{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"imgName": @"icon_wode_xitong", @"title":ASLocalizedString(@"设置"), @"sel":@"pushToSetUp"}];
    [self.table reloadData];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
- (void)pushToManageWallet {
        [self.navigationController pushViewController:[ASManageWalletVC new] animated:YES];
}
- (void)pushToTransactionRecord {
    //    [self.navigationController pushViewController:[SwitchVerificationNodeVC new] animated:YES];

}
- (void)pushToProposal {
//    [self.navigationController pushViewController:[SwitchVerificationNodeVC new] animated:YES];
}
- (void)pushToSetUp {
    [self.navigationController pushViewController:[ASSetVC new] animated:YES];
}
@end
