//
//  UIViewController+Ex.h
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Ex)
/// 简化 self.navigationController pushViewController:vc animated:YES];
- (void)push:(__kindof UIViewController *)vc;
/// 简化 [self.navigationController popViewControllerAnimated:YES];
- (void)pop;
@end

NS_ASSUME_NONNULL_END
