//
//  ASFundCell.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/5.
//  Copyright © 2020 fei. All rights reserved.
//
//  
#import <UIKit/UIKit.h>
#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASFundCell : ASTableViewCell

- (void) configCellWithCoinName:(NSString *) coinName balance:(NSString *) balance;

@end

NS_ASSUME_NONNULL_END
