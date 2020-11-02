//
//  AppDelegate.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/20.
//  Copyright © 2020 fei. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self addDebugRefresh];
    [self addNotification];

    [self setUpTabBar];
    [self setAppearance];
    return YES;
}
- (void)addDebugRefresh {
#ifdef DEBUG
    [[NSBundle bundleWithPath: @"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
#endif
}
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpTabBar) name:@"WCS_USER_CHANGE_LANGUAGE" object:nil];
}
- (void)setUpTabBar {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     
    TabBarController *vc = [TabBarController new];
    self.window.rootViewController = vc;
    [_window makeKeyAndVisible];
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



@end
