//
//  ASManageWalletVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASManageWalletVC.h"
#import "ASBackupWalletInputPSdVC.h"
#import "ASBackupWalletVC.h"
@interface ASManageWalletVC ()

@property (nonatomic, strong) ASBackupWalletInputPSdVC *inputVC;

@end

@implementation ASManageWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.rowHeight = 55;
    self.title = ASLocalizedString(@"管理钱包");
    NSString *walletName = [LambUtils shareInstance].currentUser.name;
    NSString *accountAddress = [LambUtils shareInstance].currentUser.address;
    self.datas = @[@{@"UITableViewCellStyle":@1, @"UITableViewCellAccessoryType": @0, @"title":ASLocalizedString(@"钱包名"), @"detail": walletName},
                   @{@"UITableViewCellStyle":@1, @"UITableViewCellAccessoryType": @0, @"title":ASLocalizedString(@"账户地址"), @"detail": accountAddress}
//                   @{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"title":ASLocalizedString(@"备份钱包"), @"sel":@"clickBackupWalletCell"}
    ];
    [self.table reloadData];
}
- (void)clickBackupWalletCell {
    ASBackupWalletInputPSdVC *vc = [ASBackupWalletInputPSdVC new];
    self.inputVC = vc;
    [self presentViewController: vc animated:YES completion:NULL];
    [vc.view setNeedsLayout];
    [vc.view layoutIfNeeded];
    [vc.m_sureBtn addTarget:self action:@selector(clickInputPSdVCSureBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickInputPSdVCSureBtn {

    [self dismissViewControllerAnimated:YES completion: NULL];

    if ([self.inputVC.m_tf.text isEqualToString:[LambUtils shareInstance].currentUser.password]) {
        ASBackupWalletVC *vc = [ASBackupWalletVC new];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc.view setNeedsLayout];
        [vc.view layoutIfNeeded];

        @weakify(vc);
        [[vc.m_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
            @strongify(vc);
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = vc.m_keyString;
            [ASHUD showHudTipStr:ASLocalizedString(@"复制成功")];
            [self dismissViewControllerAnimated:YES completion: NULL];

        }];
    }else{
        [ASHUD showHudTipStr:ASLocalizedString(@"密码错误")];
    }
}
@end
