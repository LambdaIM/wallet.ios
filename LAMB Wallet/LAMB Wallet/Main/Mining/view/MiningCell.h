//
//  MiningCell.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MiningCell : ASTableViewCell
@property (weak, nonatomic) IBOutlet UIView *m_contentView;
@property (weak, nonatomic) IBOutlet UILabel *m_titleLab;
@property (weak, nonatomic) IBOutlet UILabel *m_infoLab;
@property (weak, nonatomic) IBOutlet UILabel *m_statusLab;

@end

NS_ASSUME_NONNULL_END
