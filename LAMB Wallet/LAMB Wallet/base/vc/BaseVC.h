//
//  BaseVC.h
//  LAMB Wallet
//
//  Created by fei on 2020/10/22.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController
@property(nonatomic) BOOL hideNav;
- (void)hidesBackButton;
- (void)refreshUIRealTime;
@end

NS_ASSUME_NONNULL_END
