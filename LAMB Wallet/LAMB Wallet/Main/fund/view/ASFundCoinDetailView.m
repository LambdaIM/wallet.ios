//
//  ASFundCoinDetailView.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundCoinDetailView.h"
#import "UIView+Ex.h"

@interface ASFundCoinDetailView ()



@end

@implementation ASFundCoinDetailView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(2 * kLeftRightM, kLeftRightM, kScreenW - 4 * kLeftRightM, 200)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    NSArray *titleArray = @[ASLocalizedString(@"资产全称"),ASLocalizedString(@"增发类型"),ASLocalizedString(@"状态"),ASLocalizedString(@"结束时间"),ASLocalizedString(@"初始发行量"),ASLocalizedString(@"预挖矿数量"),ASLocalizedString(@"总参与额度"),ASLocalizedString(@"完成度")];
    NSArray *contentArray = @[ASLocalizedString(@"UXXB Coin"),ASLocalizedString(@"增发挖矿"),ASLocalizedString(@"增发完成"),ASLocalizedString(@"2020-10-18 18:53:19"),ASLocalizedString(@"1,000000000XXB"),ASLocalizedString(@"10,000,000XXB"),ASLocalizedString(@"100,000"),ASLocalizedString(@"100.000%")];
    
    for (int i = 0 ; i < titleArray.count; i ++) {
        UILabel *titleLab = [UILabel m3b14Text:titleArray[i]];
        titleLab.frame = CGRectMake(kLeftRightM, 70 * i, 100, 70);
        UILabel *contentLab = [UILabel m9514Text:contentArray[i]];
        contentLab.frame = CGRectMake(bgView.width - 150 - kLeftRightM, titleLab.top, 150, 70);
        contentLab.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:titleLab];
        [bgView addSubview:contentLab];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(titleLab.left, titleLab.bottom - 1, bgView.width - 2 * kLeftRightM, 0.5)];
        lineView.backgroundColor = [UIColor baseLineColor];
        [bgView addSubview:lineView];
        bgView.height = titleLab.bottom;
    }
    
    UILabel *notLab = [UILabel m3b14Text:ASLocalizedString(@"规则说明:\n1资产没有关联市场，矿工将无法进行挖矿，若果需要矿工挖矿，需要创建市场")];
    notLab.frame = CGRectMake(kLeftRightM, bgView.bottom, bgView.width - 2 * kLeftRightM, 70);
    notLab.font = [UIFont pFSize:12];
    notLab.textColor = [UIColor redColor];
    notLab.numberOfLines = 0;
    [bgView addSubview:notLab];
    bgView.height = notLab.bottom + kLeftRightM;
    [bgView addCorners:UIRectCornerAllCorners radius:8];
    
    self.height = bgView.height;
}

+ (instancetype)factoryASFundCoinDetailView {
    
    ASFundCoinDetailView *detailView = [[ASFundCoinDetailView alloc]init];
    return detailView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
