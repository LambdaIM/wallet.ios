//
//  ASFundHeadView.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/5.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ASFundHeadViewDelegate <NSObject>

- (void) transfer; // 转账
- (void) collection; // 收款
- (void) exchange;// 兑换

@end


@interface ASFundHeadView : UIView

@property (nonatomic,weak) id <ASFundHeadViewDelegate> delegate;

- (void) setLambBalance:(NSString *) balance;

@end

NS_ASSUME_NONNULL_END
