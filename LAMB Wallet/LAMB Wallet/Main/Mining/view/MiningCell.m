//
//  MiningCell.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "MiningCell.h"
#import "ASLabel.h"
#import "UIView+Ex.h"
@implementation MiningCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if ([self.m_statusLab isKindOfClass: [ASLabel class]]) {
        ((ASLabel *)self.m_statusLab).m_edgeInsets = UIEdgeInsetsMake(8, 20, 8, 20);
    }
    [self.m_statusLab addCorner: 8];
    self.contentView.backgroundColor = @"#F7F7F7".hexColor;
}


- (void)setModel:(ASNodeListModel *)model {
    self.m_titleLab.text = model.descriptions.moniker;
    NSString *per = [NSString stringWithFormat:@"%.2f%%",[model.tokens doubleValue] / [[LambNodeManager manager].bonded_tokens doubleValue] * 100];
    model.persent = per;
    self.m_infoLab.text = [NSString stringWithFormat:@"%@%@",ASLocalizedString(@"投票权重："),per];
    switch (model.status) {
        case 0:
            self.m_statusLab.text = ASLocalizedString(@"被监禁");
            self.m_statusLab.backgroundColor = [UIColor mNoPassColorAlpha:0.7];
            break;
        case 1:
            self.m_statusLab.text = ASLocalizedString(@"解绑中");
            self.m_statusLab.backgroundColor = [UIColor mNoPassColorAlpha:0.7];
            break;
        case 2:
            self.m_statusLab.text = ASLocalizedString(@"正常");
            self.m_statusLab.backgroundColor = [UIColor mPassColorAlpha:0.7];
            break;
    }
}
@end
