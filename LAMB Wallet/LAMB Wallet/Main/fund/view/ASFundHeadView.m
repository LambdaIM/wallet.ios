//
//  ASFundHeadView.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/5.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundHeadView.h"
#import "SXCodeTool.h"
#import "ASLocalizedManager.h"
#import "UIButton+ImageTitleStyle.h"
#import "ASConst.h"
#import "UIView+Ex.h"

@interface ASFundHeadView ()

@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *lambdaFoundLab;

@end

@implementation ASFundHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
  
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_card_bg"]];
    bgImageView.frame = CGRectMake(10, 10, kScreenW - 2 * 10,( kScreenW - 2 * 10) / bgImageView.image.size.width * bgImageView.image.size.height);
    [self addSubview:bgImageView];
    
    _tipLab = [UILabel text:@"余额(LAMB)" font:[UIFont pFSize:16] textColor:[UIColor whiteColor]];
    _tipLab.frame = CGRectMake(40+bgImageView.left, 40+bgImageView.top, kScreenW - 100, 20);
    [self addSubview:_tipLab];
    
    _lambdaFoundLab = [UILabel text:@"99,999.3249" font:[UIFont pFMediumSize:24] textColor:[UIColor whiteColor]];
    _lambdaFoundLab.frame = CGRectMake(_tipLab.left, _tipLab.bottom + 16, kScreenW - 100, 30);
    [self addSubview:_lambdaFoundLab];
    
    NSArray *tempTitleArray = @[ASLocalizedString(@"划转"),ASLocalizedString(@"收款"),ASLocalizedString(@"兑换")];
    NSArray *tempImageArray = @[@"home_transfer",@"home_award",@"home_exchange"];
    CGFloat left = 25;
    CGFloat width = (kScreenW - 25 * 2) / 3;
    CGFloat top = bgImageView.bottom;
    CGFloat bottom = 0;
    for (int i = 0; i < 3;  i ++) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.frame = CGRectMake(left, top, width, 110);
        [tempBtn setImage:[UIImage imageNamed:tempImageArray[i]] forState:UIControlStateNormal];
        [tempBtn setTitle:tempTitleArray[i] forState:UIControlStateNormal];
        tempBtn.titleLabel.font = [UIFont pFSize:16];
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tempBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleTop imageTitleSpace:15];
        tempBtn.tag = 100 + i;
        [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempBtn];
        left += width;
        bottom = tempBtn.bottom;
    }
    
    UIView *fundView = [[UIView alloc]initWithFrame:CGRectMake(0, bottom, kScreenW, 70)];
    fundView.backgroundColor = @"#F7F7F7".hexColor;
    [self addSubview:fundView];
    UIView *fundBgView = [[UIView alloc]initWithFrame:CGRectMake(kLeftRightM, kLeftRightM, kScreenW - 2 * kLeftRightM, fundView.height - kLeftRightM)];
    fundBgView.backgroundColor = [UIColor whiteColor];
    [fundBgView addCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:10];
    [fundView addSubview:fundBgView];
    
    UILabel *fundLab = [UILabel m3b14Text:ASLocalizedString(@"资产")];
    fundLab.font = [UIFont pFMediumSize:16];
    fundLab.frame = CGRectMake(kLeftRightM, kLeftRightM, 100, 20);
    [fundBgView addSubview:fundLab];
    
}
- (void) tempBtnClick:(UIButton *) btn {
    
    switch (btn.tag) {
        case 100:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(transfer)]) {
                [_delegate transfer];
            }
        }
            break;
        case 101:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(collection)]) {
                [_delegate collection];
            }
        }
            break;
        case 102:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(exchange)]) {
                [_delegate exchange];
            }
        }
            break;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
