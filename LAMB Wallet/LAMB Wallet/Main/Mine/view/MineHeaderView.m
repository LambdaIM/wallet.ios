//
//  MineHeaderView.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView
+(instancetype)view {
    return [[MineHeaderView alloc] initWithImage:[UIImage imageNamed: @"me_top"]];
}
-(instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        UIImageView *img1 = ({
            UIImageView *img = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"defeat_img"]];
            img;
        });
        [self addSubview: img1];
        _m_avImg = img1;
        
        UILabel *nameLab
        = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textColor = [UIColor whiteColor];
            label.text =  [LambUtils shareInstance].currentUser.name;
            label.font = [UIFont boldSystemFontOfSize:20];
            [label sizeToFit];
            label;
        });
        [self addSubview: nameLab];
        _m_nameLab = nameLab;
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.m_avImg.left = 20;
    self.m_avImg.centerY = self.height * 0.5 + 20;
    
    self.m_nameLab.centerY = self.m_avImg.centerY;
    self.m_nameLab.left = self.m_avImg.right + 20;
}
@end
