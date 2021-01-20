//
//  ASSetVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASSetVC.h"
#import "ASLanguageVC.h"
#import "SwitchVerificationNodeVC.h"
#import "SXCodeTool.h"
#import "AppDelegate.h"
#import "LoginVCViewController.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
 

@interface ASSetVC () 
@end

@implementation ASSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.table.rowHeight = 55;
    self.title = ASLocalizedString(@"设置");
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDict objectForKey:@"CFBundleShortVersionString"] ?: @"";
    
    self.datas = @[@{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"title":ASLocalizedString(@"切换验证节点"), @"sel":@"pushToSwitchVerificationNode"},
                   @{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"title":ASLocalizedString(@"语言"), @"sel":@"pushToSwitchLanguage"},
                   @{@"UITableViewCellStyle":@1, @"UITableViewCellAccessoryType": @0, @"title":ASLocalizedString(@"当前版本"), @"detail": [NSString stringWithFormat:@"%@%@", @"V", appVersion]}];
    [self.table reloadData];
    
    UIButton *btn = [self switchWalletBtn];
    [btn addTarget:self action:@selector(clickSwitchWalletBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
}

- (void)clickSwitchWalletBtn {
    UIApplication *app =[UIApplication sharedApplication];
    AppDelegate *appdele =  (AppDelegate*)app.delegate;
    LoginVCViewController *loginVC = [[LoginVCViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    appdele.window.rootViewController = nav;
    // 用户信息置空
    [LambUtils logOut];
}

- (void)pushToSwitchVerificationNode {
    [self.navigationController pushViewController:[SwitchVerificationNodeVC new] animated:YES];
}
- (void)pushToSwitchLanguage {
    [self.navigationController pushViewController:[ASLanguageVC new] animated:YES];
}

- (UIButton *)switchWalletBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.adjustsImageWhenHighlighted = NO;
    CGFloat btnH = 50;
    CGFloat btnX = 30;
    CGFloat btnW = kScreenW-2*btnX;
    CGFloat btnY = kScreenH - kll_Status_NavBarHeight - kll_SafeBottomMargin - btnH;
    btn.normalTitle = ASLocalizedString(@"切换钱包");
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [btn addCorner];
    [btn.titleLabel sizeToFit];
    btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    return  btn;
}
@end
