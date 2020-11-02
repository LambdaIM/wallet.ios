//
//  ASNavVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASNavVC.h"
#import "UIViewController+Ex.h"
#import <YYCategories/UIImage+YYAdd.h>

@interface ASNavVC ()<UINavigationControllerDelegate>

@end

@implementation ASNavVC

#pragma  mark - life cycle

+ (void)initialize {

    [[UINavigationBar appearance] setTranslucent:NO];
    NSDictionary *titleAttributeDict = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                         NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributeDict];
    UIImage *bgImg = [UIImage imageWithColor:[UIColor whiteColor]];//背景颜色
    [[UINavigationBar appearance] setBackgroundImage:bgImg
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage: [UIImage imageWithColor:  @"eaeaea".hexColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];

    // UIBarButtonItem
    UIBarButtonItem *item =
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    item.tintColor = [UIColor blackColor];//返回按钮颜色

    NSDictionary *itemAttributeDict= @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                       NSForegroundColorAttributeName : [UIColor blackColor]};
    [item setTitleTextAttributes:itemAttributeDict forState:UIControlStateNormal];
 
    
}
#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.interactivePopGestureRecognizer.delegate = self;

    self.view.backgroundColor = [UIColor  whiteColor];
    
}

- (BOOL)shouldAutorotate{
    return [self.visibleViewController shouldAutorotate];

}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (![self.visibleViewController isKindOfClass:[UIAlertController class]]) {//iOS9 UIWebRotatingAlertController
        return [self.visibleViewController supportedInterfaceOrientations];
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    // 相同页面不允许push两次
    if ([self.topViewController isKindOfClass:[viewController class]] &&
        ///
        ![NSStringFromClass([self.topViewController class]) containsString: @"Weex"] && ![NSStringFromClass([self.topViewController class]) containsString: @"KYCarGuaranteeVC"] && ![NSStringFromClass([self.topViewController class]) containsString: @"KYHourseGuaranteeVC"] ) {
        return;
    }

    // 开始push画页
    if (self.viewControllers.count) {

        // 这里设置返回按钮，理灵活些
        viewController.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_black_back"]
                                         style:UIBarButtonItemStyleDone
                                        target:viewController
                                        action:@selector(pop)];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
 


@end
