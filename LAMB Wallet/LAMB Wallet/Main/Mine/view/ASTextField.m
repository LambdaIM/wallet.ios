//
//  ASTextField.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASTextField.h"

@implementation ASTextField
- (void)config {
    self.m_leftMargin = 8;
}
-(void)awakeFromNib {
    [super awakeFromNib];
    [self config];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , self.m_leftMargin , 0 );
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , self.m_leftMargin , 0 );
}
@end
