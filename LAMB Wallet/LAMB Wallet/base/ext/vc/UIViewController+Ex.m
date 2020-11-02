//
//  UIViewController+Ex.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "UIViewController+Ex.h"

@implementation UIViewController (Ex)
#pragma mark - 简化调用
- (void)push:(__kindof UIViewController *)vc {
    if ([self isKindOfClass:[UINavigationController class]]) {
        
        [(UINavigationController *)self pushViewController:vc animated:YES];
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        
        [[(UITabBarController *)self selectedViewController] push:vc];
    } else {
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)pop {
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self;
        [nav popViewControllerAnimated:YES];
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
