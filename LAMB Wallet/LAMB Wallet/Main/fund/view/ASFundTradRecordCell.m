//
//  ASFundTradRecordCell.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundTradRecordCell.h"

@interface ASFundTradRecordCell ()

@property(nonatomic, strong) UILabel *addressNameLab;
@property(nonatomic, strong) UILabel *stateLab;
@property(nonatomic, strong) UILabel *timeLab;
@property(nonatomic, strong) UILabel *amountLab;

@end

@implementation ASFundTradRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _addressNameLab = [UILabel m3b14Text:[NSString stringWithFormat:@"%@ %@",ASLocalizedString(@"接收自"),@"lambdauio...sdfasd"]];
    _addressNameLab.frame = CGRectMake(kLeftRightM, kLeftRightM, 260, 20);
    [self.contentView addSubview:_addressNameLab];

    _stateLab = [UILabel m3b14Text:ASLocalizedString(@"成功")];
    _stateLab.frame = CGRectMake(kScreenW - 80 - kLeftRightM, _addressNameLab.top, 80, 20);
    _stateLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_stateLab];
    
    _timeLab = [UILabel m9514Text:@"2020=11-04 10:28:20"];
    _timeLab.frame = CGRectMake(_addressNameLab.left, _addressNameLab.bottom + kLeftRightM, 150, 20);
    [self.contentView addSubview:_timeLab];
    
    _amountLab = [UILabel m9514Text:@"+10TBB"];
    _amountLab.textAlignment = NSTextAlignmentRight;
    _amountLab.frame = CGRectMake(kScreenW - 150 - kLeftRightM, _timeLab.top, 150, 20);
    [self.contentView addSubview:_amountLab];
}


- (void)setModel:(ASRecordListModel *)model {

    _model = model;
    
    NSString *addMoney = @"+";
    if (model.sender) {
        self.addressNameLab.text = [NSString stringWithFormat:@"%@ %@",ASLocalizedString(@"发送到"),[model.tx.value.msg firstObject].value.to_address];
        addMoney = @"-";
        self.amountLab.textColor = [UIColor mNoPassColorAlpha:0.85];
    }else{
        self.addressNameLab.text = [NSString stringWithFormat:@"%@ %@",ASLocalizedString(@"接收自"),[model.tx.value.msg firstObject].value.from_address];
        self.amountLab.textColor = [UIColor mPassColorAlpha:0.85];
    }
    BOOL state = YES;
    for (ASRecordListLogModel *logModel in model.logs) {
        if (!logModel.success) {
            state = NO;
            break;
        }
    }
    if (state) {
        self.stateLab.text = ASLocalizedString(@"成功");
    }else{
        self.stateLab.text = ASLocalizedString(@"失败");
    }
    self.timeLab.text = [NSString getLocalDateFormateDate:model.timestamp];
    
//    self.timeLab.text = model.timestamp;

    NSString *moreString = @"";
    ASRecordTxValueMsgAmountModel *firstAmount = [[[model.tx.value.msg firstObject] value].amount firstObject];
    if ([[model.tx.value.msg firstObject] value].amount.count > 1) {
        moreString = ASLocalizedString(@"等");
    }
    self.amountLab.text = [NSString stringWithFormat:@"%@%@%@%@",addMoney,[firstAmount.amount getShowNumber:@"6"],[[[firstAmount.denom componentsSeparatedByString:@"u"] lastObject] uppercaseString],moreString];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
