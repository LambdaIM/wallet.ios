//
//  ASFundExchangeVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/6.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundExchangeVC.h"
#import "ZJScrollPageView.h"
#import "ASFundExchangeChildVC.h"

@interface ASFundExchangeVC ()<ZJScrollPageViewDelegate>

@property(nonatomic, strong) ZJScrollPageView *sv;

@end

@implementation ASFundExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    self.title = ASLocalizedString(@"兑换");
    CGRect scrollPageViewF = CGRectMake(0, 0, kScreenW
                                        , kScreenH-kll_Status_NavBarHeight-kll_SafeBottomMargin);
    ZJScrollPageView *scrollPageView =
    [[ZJScrollPageView alloc] initWithFrame:scrollPageViewF
                               segmentStyle:[self style]
                                     titles:@[[NSString stringWithFormat:@"LAMB %@ TBB",ASLocalizedString(@"兑换")], [NSString stringWithFormat:@"TBB %@ LAMB",ASLocalizedString(@"兑换")]]
                       parentViewController:self
                                   delegate:self];
    
    [self.view addSubview:scrollPageView];
    
    self.sv = scrollPageView;
}

#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return 2;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(__kindof UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    ASFundExchangeChildVC<ZJScrollPageViewChildVcDelegate> *vc = reuseViewController;
    
    if (!vc) {
        
        vc = [ASFundExchangeChildVC new];
        
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
