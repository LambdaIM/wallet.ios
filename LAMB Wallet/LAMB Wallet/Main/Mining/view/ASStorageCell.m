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
    
    if (listModel.entries) {
        ASNodeEntriesModel *entries = [listModel.entries firstObject];
//        self.utbbLab.text = [NSString stringWithFormat:@"质押 %@TBB",[entries.initial_balance getShowNumber:@"6"]];
        self.winLambLab.text = [NSString stringWithFormat:@"%@TBB",[entries.balance getShowNumber:@"6"]];
    }else{
        self.utbbLab.text = [NSString stringWithFormat:@"%@TBB",[listModel.utbb getShowNumber:@"6"]];
        self.winLambLab.text = [NSString stringWithFormat:@"%@LAMB",[listModel.winLamb getShowNumber:@"6"]];;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
