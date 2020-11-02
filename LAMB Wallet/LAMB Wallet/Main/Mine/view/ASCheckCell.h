//
//  ASCheckCell.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASCheckCell : ASTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_lab;
@property (weak, nonatomic) IBOutlet UIButton *m_btn;

@end

NS_ASSUME_NONNULL_END
