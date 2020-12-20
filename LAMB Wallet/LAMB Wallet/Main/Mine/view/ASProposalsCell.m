//
//  ASProposalsCell.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/20.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASProposalsCell.h"

@interface ASProposalsCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@end

@implementation ASProposalsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ASProposalModel *)model {
    
    _model = model;
    self.titleLab.text = model.content.value.title;
    self.contentLab.text = model.content.value.descriptions;
    self.stateLab.text = model.proposal_status;
    
    if ([model.proposal_status isEqualToString:@"Passed"]) {
        self.stateLab.backgroundColor = [UIColor mPassColor];
    }else{
        self.stateLab.backgroundColor = [UIColor mNoPassColor];
    }
}

@end
