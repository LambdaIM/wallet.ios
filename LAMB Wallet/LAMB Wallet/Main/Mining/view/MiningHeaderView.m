//
//  MiningHeaderView.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "MiningHeaderView.h"
#import "SXCodeTool.h"
#import "UIView+Ex.h"
#import "KBStoragePledgeVC.h"
#import "KBWithdrawRewardVC.h"

@interface MiningHeaderView()
@property(nonatomic, weak) UIView *m_topV;
@property(nonatomic, weak) UIView *m_bottomV;
@property(nonatomic, strong) UILabel *winLambLab;// 可提取奖励
@property(nonatomic, strong) UILabel *utbbLab;// 总的质押

@end
@implementation MiningHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat leftM = 15;
        UIView *topV = [[UIView alloc] initWithFrame:CGRectMake(leftM, 15, kScreenW-2*leftM, 180)];
        [self addSubview:topV];
        _m_topV = topV;
        topV.layer.cornerRadius = 8;
        topV.backgroundColor = [UIColor whiteColor];
        
        UILabel *tiplab1 = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString(@"可提取奖励(LAMB)") font:[UIFont pFSize:14] textColor:[UIColor blackColor]];
            [topV addSubview: lab];
            lab.top = 15;
            lab.left = 15;
            lab;
        });
        _winLambLab = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString(@"0") font:[UIFont pFBlodSize:25] textColor:[UIColor blackColor]];
            [topV addSubview: lab];
            lab.top = tiplab1.bottom + 10;
            lab.left = 15;
            lab;
        });
        
        UILabel *tiplab2 = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString(@"质押总量(TBB)") font:[UIFont pFSize:14] textColor:[UIColor blackColor]];
            [topV addSubview: lab];
            lab.top = self.winLambLab.bottom + 10;
            lab.left = 15;
            lab;
        });
        
        _utbbLab = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString(@"0") font:[UIFont pFBlodSize:25] textColor:[UIColor blackColor]];
            [topV addSubview: lab];
            lab.top = tiplab2.bottom + 10;
            lab.left = 15;
            lab;
        });
        
        UIButton *btn1 = ({
            UIButton *btn = [UIButton btn];
            btn.normalTitle = ASLocalizedString(@"提取奖励");
            btn.normalTitleColor = @"#3256E1".hexColor;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [btn sizeToFit];
            btn;
        });
        btn1.height = topV.height * 0.5;
        btn1.width = btn1.width + 2*30;
        btn1.right = topV.width - 15;
        [topV addSubview: btn1];
        
        
        UIButton *btn2 = ({
            UIButton *btn = [UIButton btn];
            btn.normalTitle = ASLocalizedString(@"质押详情");
            btn.normalTitleColor = @"#3256E1".hexColor;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [btn sizeToFit];
            btn;
        });
        btn2.width = btn1.width;
        btn2.height = btn1.height;
        btn2.right = btn1.right;
        btn2.top = btn1.bottom;
        [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
            [[self viewController] push:[KBStoragePledgeVC new]];
        }];
        [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
            [[self viewController] push:[KBWithdrawRewardVC new]];
        }];

        [topV addSubview: btn2];
        
        UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(leftM, topV.bottom+15, kScreenW-2*leftM, self.height-topV.bottom-15)];
        [self addSubview:bottomV];
        _m_bottomV = bottomV;
        bottomV.backgroundColor = [UIColor whiteColor];
        [bottomV addCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) radius:8];
        
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"请选择以下节点质押TBB挖矿") font:[UIFont pFSize:14] textColor:[UIColor blackColor]];
        [bottomV addSubview: lab];
        [lab centerYEqualSuper];
        lab.left = 15;
        lab.width = bottomV.width - 2 * 15;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        [bottomV addSubview:line];
        line.left = leftM;
        line.height = .5;
        line.bottom = bottomV.height-line.height;
        line.width = bottomV.width-2*leftM;
        line.right = bottomV.width-leftM;
    }
    return self;
}

- (void)setUtbbString:(NSString *)utbbString {
    self.utbbLab.text = [utbbString getShowNumber:@"6"];
    _utbbString = self.utbbLab.text;
    [self.utbbLab sizeToFit];
}

- (void)setWinLambString:(NSString *)winLambString {
    self.winLambLab.text = [winLambString getShowNumber:@"6"];
    _winLambString = self.winLambLab.text;
    [self.winLambLab sizeToFit];
}

@end
