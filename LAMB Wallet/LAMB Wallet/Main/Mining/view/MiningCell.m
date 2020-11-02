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
        ((ASLabel *)self.m_statusLab).m_edgeInsets = UIEdgeInsetsMake(8, 15, 8, 15);
    }
    [self.m_statusLab addCorner: 8];
    self.contentView.backgroundColor = @"#F7F7F7".hexColor;
}

@end
