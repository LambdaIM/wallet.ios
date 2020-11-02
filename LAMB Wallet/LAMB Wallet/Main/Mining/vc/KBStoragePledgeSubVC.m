//
//  KBStoragePledgeSubVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBStoragePledgeSubVC.h"
@import MJRefresh;
@interface KBStoragePledgeSubVC ()

@end

@implementation KBStoragePledgeSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)loadDataAtPage:(NSInteger)page {
    NSUInteger delaySecond = 2;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySecond * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        
        self.table.mj_footer.hidden = self.datas.count < 20;
        [self endRefresh];
    });
}
@end
