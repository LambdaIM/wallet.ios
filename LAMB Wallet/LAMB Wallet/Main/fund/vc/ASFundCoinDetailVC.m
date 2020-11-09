//
//  ASFundCoinDetailVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundCoinDetailVC.h"
#import "ASFundCoinDetailView.h"

@interface ASFundCoinDetailVC ()

@end

@implementation ASFundCoinDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    self.coinName = @"XXB";
    self.title = [NSString stringWithFormat:@"%@%@",self.coinName,ASLocalizedString(@"资产详情")];
    self.table.tableHeaderView = [ASFundCoinDetailView factoryASFundCoinDetailView];
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
