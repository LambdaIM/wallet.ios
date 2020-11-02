//
//  TabBarController.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "TabBarController.h"

#import "ASNavVC.h"
static NSString *const kClassKey  = @"rootVCClassString";
static NSString *const kTitleKey  =  @"title";
static NSString *const kImgKey    =  @"imageName";
static NSString *const kSelImgKey = @"selectedImageName";

@interface TabBarController ()

@end

@implementation TabBarController

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray *childItemsArray = @[
        
        @{kClassKey  : @"MiningVC",
          kTitleKey  : ASLocalizedString(@"资产"),
          kImgKey    : @"icon_tabbar_sy",
          kSelImgKey : @"icon_tabbar_sy_selected"},
        
        @{kClassKey  : @"MiningVC",
          kTitleKey  : ASLocalizedString(@"挖矿"),
          kImgKey    : @"icon_tabbar_yk",
          kSelImgKey : @"icon_tabbar_yk_selected"},
        
        
        @{kClassKey  : @"MineVC",
          kTitleKey  : ASLocalizedString(@"我的"),
          kImgKey    : @"icon_tabbar_mine",
          kSelImgKey : @"icon_tabbar_mine_selected"} ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        
        vc.title = dict[kTitleKey];
        vc.tabBarItem.title = vc.title;
        
        ASNavVC *nav = [[ASNavVC alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self addChildViewController:nav];
        
    }];
    self.tabBar.translucent = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
}


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
@end
