//
//  ASFundTradRecordVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/15.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASProposalsVC.h"
@import MJRefresh;
#import "ASFundTradRecordCell.h"

@interface ASProposalsVC ()

@end

@implementation ASProposalsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self reqeustData];
    
    [self requestDetail:@"1"];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    self.title = ASLocalizedString(@"提案");
    self.table.rowHeight = 80;
    [self.table registerClass:[ASFundTradRecordCell class] forCellReuseIdentifier:@"ASFundTradRecordCell"];
}

-(void)loadDataAtPage:(NSInteger)page {
    NSUInteger delaySecond = 2;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySecond * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        self.table.mj_footer.hidden = self.datas.count < 20;
        [self endRefresh];
    });
}

- (void) reqeustData {
    
    [LambNetManager GET:getHTTP_Get_proposal_list parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void) requestDetail:(NSString *) detailId {
    [LambNetManager GET:JoinParam(getHTTP_Get_proposal_details, detailId) parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
