//
//  ASFundTradRecordVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//
//  交易记录列表
#import "ASFundTradRecordVC.h"
@import MJRefresh;
#import "ASFundTradRecordCell.h"

@interface ASFundTradRecordVC ()

@end

@implementation ASFundTradRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    self.title = ASLocalizedString(@"交易记录");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
