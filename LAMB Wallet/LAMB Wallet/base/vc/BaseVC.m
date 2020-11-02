//
//  BaseVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/22.
//  Copyright © 2020 fei. All rights reserved.
//

#import "BaseVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseVC ()

@end

@implementation BaseVC

#pragma mark -  life cycle
- (void)dealloc {
    NSLog(@"--销毁页面--%@---", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = @"#F7F7F7".hexColor;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"--进入页面--%@---", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self endEditing];
    [self resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"----收到了内存警告的页面：%@---", self.title);
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (void)endEditing {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
-(void)setHideNav:(BOOL)hideNav {
    _hideNav = hideNav;
    
    self.fd_prefersNavigationBarHidden = _hideNav;

}
- (void)hidesBackButton {
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    self.fd_interactivePopDisabled = YES;
    
    // 不用系统的item这行代码有效果，可以隐藏返回按钮
    self.navigationItem.leftBarButtonItem = nil;
    // 用系统的item这行代码有效果，可以隐藏返回按钮
    self.navigationItem.hidesBackButton =YES;
}
#pragma mark - 实时刷新
/// 开启 实时刷新 UI
- (void)refreshUIRealTime {
#if DEBUG
    @weakify(self);
    [[NSNotificationCenter defaultCenter] addObserverForName:@"INJECTION_BUNDLE_NOTIFICATION" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self);
        while (self.view.subviews.count) {
            UIView* child = self.view.subviews.lastObject;
            [child removeFromSuperview];
        }
        [self viewDidLoad];
    }];
#endif
}

@end
