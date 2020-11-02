//
//  KBVerifyNodeDetailVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBVerifyNodeDetailVC.h"
#import "UIView+Ex.h"
#import "SXCodeTool.h"
#import "UIImage+Ex.h"
#import "KBPledgeVC.h"
#import "KBTransferPledgeVC.h"

@interface KBVerifyNodeDetailVC ()
@property(nonatomic, weak) UIScrollView *m_scroll;
@property(nonatomic, weak) UIButton *m_btn1;
@property(nonatomic, weak) UIButton *m_btn2;
@property(nonatomic, weak) UIButton *m_btn3;

@end

@implementation KBVerifyNodeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = ASLocalizedString(@"验证节点详情");
    
    UIScrollView *ms = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:ms];
    self.m_scroll = ms;
    ms.contentSize = CGSizeMake(kScreenW, kScreenH);
    NSArray<NSDictionary<NSString *, NSString *> *> *dicts =
    @[@{@"title": @"节点昵称", @"value": @"cv-moniker-10"},
      @{@"title": @"我的质押", @"value": @"0TBB"},
      @{@"title":@"我的奖励", @"value": @"0LAMB"},
      @{@"title": @"质押地址", @"value": @"lambdavalojljlsjflsjal"},

      @{@"title": @"简   介", @"value": @" [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)  [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)  [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)  [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)  [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)  [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) "},

      @{@"title": @"节点收益", @"value": @"25%"},
      @{@"title": @"最大收益", @"value": @"25%"},
      @{@"title": @"最大收益变化", @"value": @"1%"},
      @{@"title": @"投票权重", @"value": @"9.43%"},
    ];
    CGFloat leftM = 15;
    UIView *topV = [[UIView alloc] initWithFrame:CGRectMake(leftM, leftM, kScreenW-2*leftM, 220)];
    [ms addSubview: topV];
    topV.backgroundColor = [UIColor whiteColor];
    __block UILabel *lastLab = nil;
    [dicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *tipLab = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString([NSString stringWithFormat:@"%@%@", obj[@"title"], @"："]) font:[UIFont pFSize:14] textColor:[UIColor blackColor]];
            [topV addSubview: lab];
            if (idx == 0) {
                lab.top = 10;
            } else {
                lab.top = lastLab.bottom + 15;
            }
            lab.left = 15;
            lab;
        });
        
        [topV addSubview: tipLab];
        UILabel *valueLab = ({
            UILabel *lab =
            [UILabel text:obj[@"value"] font:[UIFont pFSize:14] textColor:[UIColor lightGrayColor]];
            lab.numberOfLines = 0;
            [topV addSubview: lab];
            lab.top = tipLab.top;
            lab.left = tipLab.right + 8;
            lab.width = topV.width - 15 - lab.left;
            [lab sizeToFit];
            lab;
        });
        [topV addSubview: valueLab];
        lastLab = valueLab;
    }];
    
    topV.height = lastLab.bottom + 30;
    
    topV.layer.cornerRadius = 8;
    ms.contentSize = CGSizeMake(kScreenW, MAX(topV.bottom + 20, kScreenH));
    
    CGFloat svH = 50;
    CGFloat btnM = 10;
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-kll_Status_NavBarHeight - svH -kll_SafeBottomMargin, kScreenW, svH)];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomV];
    
    UIButton *btn1 = [UIButton btn];
    btn1.normalTitle = ASLocalizedString(@"取消质押");
    [bottomV addSubview: btn1];
    UIEdgeInsets btnInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    btn1.contentEdgeInsets = btnInsets;
    
    
    UIButton *btn2 = [UIButton btn];
    btn2.normalTitle = ASLocalizedString(@"转质押");
    [bottomV addSubview: btn2];
    btn2.contentEdgeInsets = btnInsets;
    
    UIButton *btn3 = [UIButton btn];
    btn3.normalTitle = ASLocalizedString(@"TBB质押挖矿");
    [bottomV addSubview: btn3];
    btn3.contentEdgeInsets = btnInsets;

    self.m_btn1 = btn1;
    [btn1 sizeToFit];
    [btn2 sizeToFit];
    [btn3 sizeToFit];
    self.m_btn2 = btn2;
    self.m_btn3 = btn3;
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    @weakify(self);
    [[btn1  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        KBPledgeVC *vc = [KBPledgeVC new];
        vc.m_cancel = YES;
        [self push:vc];
    }];
    [[btn2  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        KBTransferPledgeVC *vc = [KBTransferPledgeVC new];
        [self push:vc];
    }];
    [[btn3  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        KBPledgeVC *vc = [KBPledgeVC new];
        [self push:vc];
    }];
    
    [btn1 centerYEqualSuper];
    btn1.left = (bottomV.width -  btn1.width - btn2.width - btn3.width - 2*btnM) * 0.5;
    if (btn1.left < 0) {
        NSLog(@"---%@---",@"f");
    }
    btn2.left = btn1.right + btnM;
    btn2.centerY = btn1.centerY;
    btn3.left = btn2.right + btnM;
    btn3.centerY = btn2.centerY;
    if (kll_SafeBottomMargin > 0) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-kll_Status_NavBarHeight - kll_SafeBottomMargin, kScreenW, kll_SafeBottomMargin)];
        v.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:v];

    }
    [bottomV sizeToFit];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.m_scroll.frame = self.view.bounds;
    self.m_scroll.height = kScreenH - kll_Status_NavBarHeight - 50 - kll_SafeBottomMargin;
    [@[self.m_btn1, self.m_btn2, self.m_btn3] enumerateObjectsUsingBlock:^(UIButton*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!btn.normalBackgroundImage) {
            btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
            [btn addCorners:UIRectCornerAllCorners radius:btn.height*0.5];
        }
    }];
    
}

@end
