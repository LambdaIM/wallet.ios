//
//  AppDelegate.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/20.
//  Copyright © 2020 fei. All rights reserved.
//

#import "AppDelegate.h"
//#import <CoreBitcoin/CoreBitcoin.h>
#import "TabBarController.h"
#import "LoginVCViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self iOS14CellBgColorFix];
        
    [self addNotification];

    [self setUpTabBar];
    
    if (![LambUtils userLogin]) {
        [self logOut];
    }
    
    [self setAppearance];
    
    return YES;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpTabBar) name:kUSER_CHANGE_LANGUAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpTabBar) name:kUSER_LOGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut) name:kUSER_LOGOUT object:nil];
}

- (void)setUpTabBar {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     
    TabBarController *vc = [TabBarController new];
    self.window.rootViewController = vc;
    [_window makeKeyAndVisible];
}

- (void)logOut {
    
    LoginVCViewController *loginVC = [[LoginVCViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
    [_window makeKeyAndVisible];
    // 用户信息置空
    [LambUtils logOut];
}

- (void)setAppearance {
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}

-(void)initKeyboardManager
{
    
}

/// ios
- (void)iOS14CellBgColorFix {
    if (@available(iOS 14, *)) {
        UIBackgroundConfiguration* backgroundConfig = [UIBackgroundConfiguration listPlainCellConfiguration];
        backgroundConfig.backgroundColor = UIColor.clearColor;
        [UITableViewCell appearance].backgroundConfiguration = backgroundConfig;
        
        UIBackgroundConfiguration* backgroundConfig2 = [UIBackgroundConfiguration listPlainHeaderFooterConfiguration];
        backgroundConfig2.backgroundColor = UIColor.clearColor;
        [UITableViewHeaderFooterView appearance].backgroundConfiguration = backgroundConfig2;
        [UITableViewHeaderFooterView appearance].backgroundConfiguration = backgroundConfig2;
    }
}


@end
