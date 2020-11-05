//
//  ASFundCell.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/5.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundCell.h"
#import "SXCodeTool.h"
#import "ASConst.h"
@interface ASFundCell ()

@property (nonatomic, strong) UILabel *coinNameLab;
@property (nonatomic, strong) UILabel *balanceLab;
@property (nonatomic, strong) UIImageView *arrowImage;

@end

@implementation ASFundCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setupUI {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kLeftRightM, 0, kScreenW - 2 * kLeftRightM, 80)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    _coinNameLab = [UILabel m3b14Text:@"LAMB"];
    _coinNameLab.frame = CGRectMake(kLeftRightM, kLeftRightM, 100, 20);
    _balanceLab = [UILabel m9514Text:@"99,999.2343 LAMB"];
    _balanceLab.frame = CGRectMake(kLeftRightM, _coinNameLab.bottom + 10, 150, 20);
    [bgView addSubview:_coinNameLab];
    [bgView addSubview:_balanceLab];
    
    _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_more"]];
    _arrowImage.frame = CGRectMake(bgView.width - kLeftRightM - _arrowImage.width, (bgView.height - _arrowImage.height) / 2, _arrowImage.width, _arrowImage.height);
    [bgView addSubview:_arrowImage];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_coinNameLab.left, bgView.height - 2, bgView.width - 2 * kLeftRightM, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:241 green:241 blue:241 alpha:1];
    [bgView addSubview:lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
