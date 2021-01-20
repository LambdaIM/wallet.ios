//
//  ASMnemonicVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/9.
//  Copyright © 2021 fei. All rights reserved.
//

#import "KBMnemonicVC.h"
#import "KBBipManager.h"
#import "XLChannelView.h"
#import "UIView+Ex.h"
#import "UIImage+Ex.h"
#import <YYCategories/NSArray+YYAdd.h>
#import "NSData+KBChange.h"
//#import <TrezorCrypto/segwit_addr.h>
#import "LAMB_Wallet-Swift.h"


@interface KBMnemonicVC ()

@property (nonatomic, strong) XLChannelView *channelView;
@property (nonatomic, strong) NSArray *mnemonic;// 助剂词

@end

@implementation KBMnemonicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = ASLocalizedString(@"助记词");
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
    
    if (self.confirmMnemonic) {
        [self verticalMnemoinc];
    }else{
        [self getMnemonic];
    }
    
    
//    self.table.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 80)];
    NSString *tipString = self.confirmMnemonic ? ASLocalizedString(@"请单击助记词以确认您已正确备份"):ASLocalizedString(@"请将助记词按顺序认真抄写在\n纸上之后将进行验证");
    UILabel *tipLab = [UILabel text:tipString font:[UIFont systemFontOfSize:15] textColorStr:@"000080"];
    tipLab.textAlignment = NSTextAlignmentCenter;
//    tipLab.textColor = [UIColor mMnemonicColor];
    tipLab.numberOfLines = 0;
    tipLab.frame = headView.frame;
    [headView addSubview:tipLab];
    [self.view addSubview:headView];
    
    CGFloat height = 0;
    
    if (self.confirmMnemonic) {
        height = ((kScreenW - 20 - (3 + 1) * kLeftRightM)/3 / 3 * 1.15 + 10 ) * 8 + kLeftRightM + 130;
        self.channelView = [[XLChannelView alloc] initWithFrame:CGRectMake(10, headView.bottom, kScreenW - 20, height)enableSelect:YES];

    }else{
        height = ((kScreenW - 20 - (3 + 1) * kLeftRightM)/3 / 3 * 1.15 + 10 ) * 8 + kLeftRightM * 2;
        self.channelView = [[XLChannelView alloc] initWithFrame:CGRectMake(10, headView.bottom, kScreenW - 20, height)enableSelect:NO];
    }
        
    self.channelView.layer.cornerRadius = 10;
    self.channelView.clipsToBounds = YES;
    
    [self.view addSubview:self.channelView];
    
    UIButton *btn = [UIButton btn];
    btn.frame = CGRectMake(kLeftRightM, kScreenH - kll_Tabbar_SafeBottomHeight - 10 - kll_Status_NavBarHeight, kScreenW - 2 * kLeftRightM, 49);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIImage *normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [btn addCorners:UIRectCornerAllCorners radius:btn.height*0.5];
    btn.normalBackgroundImage = normalBackgroundImage;
    [btn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.normalTitleColor = [UIColor whiteColor];
    btn.normalTitle = self.confirmMnemonic ? ASLocalizedString(@"确认") : ASLocalizedString(@"我已抄写完成，开始验证");
    [self.view addSubview:btn];
}

- (void) continueAction:(UIButton *) btn {
    if (self.confirmMnemonic) {
        // 助剂词验证
        if (self.channelView.enabledTitles.count == self.mnemonic.count) {
            BOOL state = YES;
            for (int i = 0; i < self.channelView.enabledTitles.count; i++) {
              
                NSString *c1 = [self.channelView.enabledTitles objectAtIndex:i];
                NSString *c2 = [[LambUtils shareInstance].currentUser.mnemonic objectAtIndex:i];
                if (![c1 isEqualToString:c2]) {
                    state = NO;
                    [ASHUD showHudTipStr:ASLocalizedString(@"助记词校验错误")];
                    break;
                }
            }
            
            // 校验成功
            if (state) {
                
                [LambUtils creatMnemonicWithWords:[LambUtils shareInstance].currentUser.mnemonic];
                
                if ([LambUtils shareInstance].currentUser.address.length) {
                    [LambUtils saveUserInfo:[LambUtils shareInstance].currentUser];
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kUSER_LOGIN object:nil];
                }else{
                    [ASHUD showHudTipStr:ASLocalizedString(@"地址错误")];
                }
            }else{
                [ASHUD showHudTipStr:ASLocalizedString(@"助记词校验错误")];
            }
        }else{
            [ASHUD showHudTipStr:ASLocalizedString(@"请选择助记词")];
        }
    }else{
        if (self.mnemonic) {
            [LambUtils shareInstance].currentUser.mnemonic = self.mnemonic;
        }
        KBMnemonicVC *volatileVc = [[KBMnemonicVC alloc]init];
        volatileVc.confirmMnemonic = YES;
        [self.navigationController pushViewController:volatileVc animated:YES];
    }
}

/// 获取助剂词
- (void) getMnemonic {
    
    NSString *mnemonicString = [KBBipManager generateMnemonicString:@256 language:@"english" ];
    mnemonicString = @"tide loyal leave bunker kid mutual cage more keen can whisper label simple exchange analyst raise small pink model cloth all quantum catch worry";
    
    if ([mnemonicString isNotBlank]) {
        self.mnemonic = [mnemonicString componentsSeparatedByString:@" "];
        self.channelView.enabledTitles = [NSMutableArray arrayWithArray:self.mnemonic];
        self.channelView.disabledTitles = [NSMutableArray array];
        [self.channelView reloadData];
    }
    NSLog(@"====%@",mnemonicString);
}

/// 验证助剂词
- (void) verticalMnemoinc {
    if ([LambUtils shareInstance].currentUser.mnemonic) {
        self.mnemonic = [NSArray arrayWithArray:[LambUtils shareInstance].currentUser.mnemonic];
        NSMutableArray *disAbleArray = [NSMutableArray arrayWithArray:self.mnemonic];
        [disAbleArray shuffle];
//        self.channelView.enabledTitles = [NSMutableArray array];
//        self.channelView.disabledTitles = disAbleArray;
        
        self.channelView.enabledTitles = [NSMutableArray arrayWithArray:self.mnemonic];
        self.channelView.disabledTitles = [NSMutableArray array];

        [self.channelView reloadData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
