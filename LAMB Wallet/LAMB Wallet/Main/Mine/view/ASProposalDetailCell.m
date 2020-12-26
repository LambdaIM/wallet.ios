//
//  ASProposalDetailCell.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/20.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASProposalDetailCell.h"
#import "NSString+KBChange.h"

@interface ASProposalDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleTipLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *stateTipLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *numberTipLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *startTipLab;
@property (weak, nonatomic) IBOutlet UILabel *startLab;
@property (weak, nonatomic) IBOutlet UILabel *endTipLab;
@property (weak, nonatomic) IBOutlet UILabel *endLab;
@property (weak, nonatomic) IBOutlet UILabel *needTipLab;
@property (weak, nonatomic) IBOutlet UILabel *needLab;
@property (weak, nonatomic) IBOutlet UILabel *saveTipLab;
@property (weak, nonatomic) IBOutlet UILabel *saveberLab;
@property (weak, nonatomic) IBOutlet UILabel *mySaveTipLab;
@property (weak, nonatomic) IBOutlet UILabel *mySaveLab;
@property (weak, nonatomic) IBOutlet UILabel *myTouPiaoTipLab;
@property (weak, nonatomic) IBOutlet UILabel *myTouPiaoLab;
@property (weak, nonatomic) IBOutlet UILabel *touPiaoTipLab;
@property (weak, nonatomic) IBOutlet UILabel *touPiaoLab;
@property (weak, nonatomic) IBOutlet UILabel *agreeTipLab;
@property (weak, nonatomic) IBOutlet UILabel *agreeLab;
@property (weak, nonatomic) IBOutlet UILabel *refuseTipLab;
@property (weak, nonatomic) IBOutlet UILabel *refuseLab;
@property (weak, nonatomic) IBOutlet UILabel *refuseMoreTipLab;
@property (weak, nonatomic) IBOutlet UILabel *refuseMoreLab;
@property (weak, nonatomic) IBOutlet UILabel *giveUpTipLab;
@property (weak, nonatomic) IBOutlet UILabel *giveUpLab;
@property (weak, nonatomic) IBOutlet UILabel *typeTipLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *destoryTipLab;
@property (weak, nonatomic) IBOutlet UILabel *destoryLab;
@property (weak, nonatomic) IBOutlet UILabel *detailTipLab;
@property (weak, nonatomic) IBOutlet UILabel *dtailLab;

@end

@implementation ASProposalDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleTipLab.text = ASLocalizedString(@"提案：");
    self.stateTipLab.text = ASLocalizedString(@"状态：");
    self.numberTipLab.text = ASLocalizedString(@"编号：");
    self.startTipLab.text = ASLocalizedString(@"投票开始时间：");
    self.endTipLab.text = ASLocalizedString(@"投票结束时间：");
    self.needTipLab.text = ASLocalizedString(@"需要押金：");
    self.saveTipLab.text = ASLocalizedString(@"已存押金：");
    self.mySaveTipLab.text = ASLocalizedString(@"我存的押金：");
    self.myTouPiaoTipLab.text = ASLocalizedString(@"我的投票：");
    self.touPiaoTipLab.text = ASLocalizedString(@"投票总量：");
    self.agreeTipLab.text = ASLocalizedString(@"同意：");
    self.refuseTipLab.text = ASLocalizedString(@"反对：");
    self.refuseMoreTipLab.text = ASLocalizedString(@"强烈反对：");
    self.giveUpTipLab.text = ASLocalizedString(@"弃权：");
    self.typeTipLab.text = ASLocalizedString(@"类型：");
    self.destoryTipLab.text = ASLocalizedString(@"销毁金额：");
    self.detailTipLab.text = ASLocalizedString(@"详细内容：");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(ASProposalModel *)model{
    
    _model = model;
    
    self.titleLab.text = model.content.value.title;
    self.stateLab.text = model.proposal_status_string;
    self.numberLab.text = model.ids;
    self.startLab.text = [NSString getLocalDateFormateUTCDate:model.voting_start_time];
    self.endLab.text = [NSString getLocalDateFormateUTCDate:model.voting_end_time];
    if (model.min_deposit) {
        self.needLab.text = model.min_deposit.amount;
    }else{
        self.needLab.text = @"";
    }
    self.saveberLab.text = [model.total_deposit firstObject].amount;
    self.mySaveLab.text = @"";
    self.myTouPiaoLab.text = @"";
    double totalCount = [model.final_tally_result.abstain doubleValue] + [model.final_tally_result.yes doubleValue] + [model.final_tally_result.no doubleValue] + [model.final_tally_result.no_with_veto doubleValue];
    self.touPiaoLab.text = [NSString stringWithFormat:@"%lf",totalCount];
    self.agreeLab.text = [NSString stringWithFormat:@"%@(%.2f%%)",model.final_tally_result.yes,[model.final_tally_result.yes doubleValue]/totalCount*100];
    self.refuseLab.text = [NSString stringWithFormat:@"%@(%.2f%%)",model.final_tally_result.no,[model.final_tally_result.no doubleValue]/totalCount*100];
    self.refuseMoreLab.text = [NSString stringWithFormat:@"%@(%.2f%%)",model.final_tally_result.no_with_veto,[model.final_tally_result.no_with_veto doubleValue]/totalCount*100];
    self.giveUpLab.text = [NSString stringWithFormat:@"%@(%.2f%%)",model.final_tally_result.abstain,[model.final_tally_result.abstain doubleValue]/totalCount*100];
    self.typeLab.text = model.content.typeString;
    if (model.content.value.burn_amount) {
        self.destoryLab.text = [model.content.value.burn_amount firstObject].amount;
    }else{
        self.destoryLab.text = @"";
    }
    self.dtailLab.text = model.content.value.descriptions;
}

@end
