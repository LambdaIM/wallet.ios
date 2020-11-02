//
//  KBStoragePledgeVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBStoragePledgeVC.h"
#import "ZJScrollPageViewDelegate.h"
#import "ZJSegmentStyle.h"
#import "ZJScrollPageView.h"
#import "KBStoragePledgeSubVC.h"

@interface KBStoragePledgeVC ()<ZJScrollPageViewDelegate>
@property(nonatomic, weak) ZJScrollPageView *sv;

@end

@implementation KBStoragePledgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUIRealTime];
    self.title = ASLocalizedString(@"存储质押");
    CGRect scrollPageViewF = CGRectMake(0, 0, kScreenW
                                        , kScreenH-kll_Status_NavBarHeight-kll_SafeBottomMargin);
    ZJScrollPageView *scrollPageView =
    [[ZJScrollPageView alloc] initWithFrame:scrollPageViewF
                               segmentStyle:[self style]
                                     titles:@[ASLocalizedString(@"我的质押"), ASLocalizedString(@"解绑中")]
                       parentViewController:self
                                   delegate:self];
    
    [self.view addSubview:scrollPageView];
    
    self.sv = scrollPageView;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.sv.frame = self.view.bounds;
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return 2;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(__kindof UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    KBStoragePledgeSubVC<ZJScrollPageViewChildVcDelegate> *vc = reuseViewController;
    
    if (!vc) {
        
        vc = [KBStoragePledgeSubVC new];
        
    }
    return vc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (ZJSegmentStyle *)style {
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.titleMargin = 30;
    //    style.segmentBgColor = @"#f9f9f9);
    style.showLine = YES;
    style.scrollTitle = YES;
    style.segmentHeight = 58;
    style.scrollLineHeight = 1.5f;
    style.adjustCoverOrLineWidth = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollLineColor = @"#3256E1".hexColor;
    style.normalTitleColor = @"#4F5565".hexColor;
    style.selectedTitleColor = @"#3256E1".hexColor;
    style.titleFont = [UIFont systemFontOfSize:14 weight: UIFontWeightMedium];
    return style;
}

@end
