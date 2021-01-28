//
//  WCSGoogleVerifyView.h
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASVerifyPasswordView : UIView

/*
 *  <#blockNema#> block
 */
@property (nonatomic, copy) void(^confirmPassword)(BOOL state);// 


- (void) showWihtType:(NSString *) verifyType gas:(NSString *) gas;

- (void) dismiss;

+ (ASVerifyPasswordView *) factoryWCSGoogleVerifyView;

@end

NS_ASSUME_NONNULL_END
