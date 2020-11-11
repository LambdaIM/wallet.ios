//
//  KBImportPocketVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBImportPocketVC.h" 
#import "KBMnemonicImportVC.h"
#import "KBFileImportVC.h"
#import "ZJScrollPageViewDelegate.h"
#import "ZJSegmentStyle.h"
#import "ZJScrollPageView.h"


@interface KBImportPocketVC ()<ZJScrollPageViewDelegate>

@property(nonatomic, weak) ZJScrollPageView *sv;

@end

@implementation KBImportPocketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ASLocalizedString(@"导入钱包");
    CGRect scrollPageViewF = CGRectMake(0, 0, kScreenW
                                        , kScreenH-kll_Status_NavBarHeight-kll_SafeBottomMargin);
    ZJScrollPageView *scrollPageView =
    [[ZJScrollPageView alloc] initWithFrame:scrollPageViewF
                               segmentStyle:[self style]
                                     titles:@[ASLocalizedString(@"配置文件导入"), ASLocalizedString(@"助记词导入")]
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
    
    if(index == 0){
        return [[KBFileImportVC alloc] init];
    }else {
        return [[KBMnemonicImportVC alloc] init];
    }
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
