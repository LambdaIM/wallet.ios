//
//  ASCheckCell.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASCheckCell.h"

@implementation ASCheckCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.m_lab.text = nil;
    self.m_btn.selected = NO;
}

@end
