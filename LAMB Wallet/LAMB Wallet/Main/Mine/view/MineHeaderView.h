//
//  MineHeaderView.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView : UIImageView
+ (instancetype)view;
@property(nonatomic, weak) UIImageView *m_avImg;
@property(nonatomic, weak) UILabel *m_nameLab;
@end

NS_ASSUME_NONNULL_END
