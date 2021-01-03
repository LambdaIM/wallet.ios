//
//  ASStorageCell.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/3.
//  Copyright © 2021 fei. All rights reserved.
//

#import "ASStorageCell.h"

@interface ASStorageCell ()

@property (weak, nonatomic) IBOutlet UILabel *nodeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *utbbLab;
@property (weak, nonatomic) IBOutlet UILabel *winLambLab;

@end

@implementation ASStorageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setListModel:(ASNodeListModel *)listModel {
    _listModel = listModel;
    self.nodeNameLab.text = listModel.descriptions.moniker;
    self.utbbLab.text = [NSString stringWithFormat:@"%@TBB",[listModel.utbb getShowNumber:@"6"]];
    self.winLambLab.text = [NSString stringWithFormat:@"%@LAMB",[listModel.winLamb getShowNumber:@"6"]];;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
