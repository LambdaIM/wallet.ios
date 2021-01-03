//
//  KBWithdrawRewardSubVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBWithdrawRewardSubVC.h"
#import "SXCodeTool.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface KBWithdrawRewardSubVC ()

@end

@implementation KBWithdrawRewardSubVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLab1 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"提取数额") font:[UIFont pFSize:18] textColor:[UIColor blackColor]];
        [self.view addSubview: lab];
        [lab sizeToFit];
        lab.top = 10;
        lab.left = kLeftRightM;
        lab;
    });
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kLeftRightM, tipLab1.bottom+8, kScreenW-2*kLeftRightM - 60, 80)];
    [self.view addSubview: tf];
    tf.text = self.m_nodeRevenue ? @"0" : [LambNodeManager manager].canWinCoinArray.count > 0 ? [[[LambNodeManager manager].canWinCoinArray firstObject].amount getNumber:@"6"] : @"0";
    tf.font = [UIFont pFBlodSize:30];
//    if (tf.text.length <= 0 || [tf.text isEqualToString:@"0"]) {
//        tf.userInteractionEnabled = NO;
//    }
    tf.userInteractionEnabled = NO;
    
    UILabel *tipLab2 = ({
        UILabel *lab =
        [UILabel text:@"LAMB" font:[UIFont pFSize:18] textColor:[UIColor blackColor]];
        [self.view addSubview: lab];
        [lab sizeToFit];
        lab.centerY = tf.centerY + 5;
        lab.right = kScreenW - kLeftRightM;
        lab;
    });
    
    UIView *line = [UIView new];
    line.backgroundColor = @"#B0B0B0".hexColor;
    [self.view addSubview: line];
    line.left = tf.left;
    line.top = tf.bottom;
    line.width = kScreenW - 2 * kLeftRightM;
    line.height = .5;
    
    UIView *tempV = nil;
    if (self.m_nodeRevenue) {
        tempV = line;
    } else {
        UILabel *tipLab3 = ({
            UILabel *lab =
            [UILabel text: ASLocalizedString(@"*一次只能从5个验证节点中提取奖励") font:[UIFont pFSize:14] textColor:@"ED204E".hexColor];
            [self.view addSubview: lab];
            [lab sizeToFit];
            lab.top = line.bottom + 10;
            lab.left = line.left;
            lab.width = line.width;
            [lab sizeToFit];
            lab;
        });
        tempV = tipLab3;
    }
    
    
    UIButton *btn = [UIButton btn];
    btn.normalTitle = ASLocalizedString(@"确认提取");
    [self.view addSubview: btn];
    CGFloat btnX = 60;
    btn.frame = CGRectMake(btnX, tempV.bottom + 80, kScreenW-2*btnX, 50);
    btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [btn addCorner];
}

@end
