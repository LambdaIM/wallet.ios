//
//  ASFundExchangeChildVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/6.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundExchangeChildVC.h"
#import "ZJScrollPageViewDelegate.h"
#import "ASTextField.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
@interface ASFundExchangeChildVC ()<ZJScrollPageViewChildVcDelegate>

@property(nonatomic, strong) ASTextField *amountField;

@end

@implementation ASFundExchangeChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *leftTipLab = [UILabel m9514Text:ASLocalizedString(@"金额（LAMB）")];
    leftTipLab.font = [UIFont pFSize:14];
    leftTipLab.frame = CGRectMake(30, 30, 120, 20);
    [self.view addSubview:leftTipLab];
    
    UILabel *rightTipLab = [UILabel m9514Text:ASLocalizedString(@"金额（TBB）")];
    rightTipLab.font = [UIFont pFSize:14];
    rightTipLab.frame = CGRectMake(leftTipLab.right, leftTipLab.top, kScreenW - leftTipLab.right - 30, 20);
    rightTipLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:rightTipLab];
    
    _amountField = [[ASTextField alloc] initWithFrame:CGRectMake(leftTipLab.left - 10, leftTipLab.bottom + 10, 130, 50)];
    _amountField.layer.cornerRadius = 8;
    _amountField.placeholder = ASLocalizedString(@"填写数额");
    _amountField.font = [UIFont pFMediumSize:20];
    [self.view addSubview:_amountField];
    
    
    UIImageView *exchangeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_fuihuan"]];
    exchangeImageView.frame = CGRectMake((kScreenW - exchangeImageView.image.size.width ) / 2, leftTipLab.bottom + 5, exchangeImageView.size.width, exchangeImageView.size.height);
    [self.view addSubview:exchangeImageView];
    
    
    UILabel *rightCoinLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW - 100 - 30, rightTipLab.bottom + 20, 100, 30)];
    rightCoinLab.centerY = _amountField.centerY;
    rightCoinLab.text = @"0";
    rightCoinLab.font = [UIFont pFMediumSize:20];
    rightCoinLab.textColor = @"#3256E1".hexColor;
    rightCoinLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightCoinLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _amountField.bottom + 20, kScreenW, 0.5)];
    lineView.backgroundColor = @"#3b3b3b".hexColor;
    [self.view addSubview:lineView];
    
    UILabel *tipLab = [UILabel m9514Text:ASLocalizedString(@"特别注意: \n1:LAMB:TBB=3000:1且TBB必须为整数 \n2:只有使用LAMB兑换的TBB才可以兑换回LAMB \n3:LAMB兑换生成的TBB是根据您的Lambda钱包私钥确认 \n4:TBB转账无法转移TBB兑回LAMB的权益。")];
    tipLab.numberOfLines = 0;
    tipLab.font = [UIFont pFSize:14];
    tipLab.textColor = [UIColor redColor];
    tipLab.frame = CGRectMake(kLeftRightM, lineView.bottom + kLeftRightM, kScreenW - 2 * kLeftRightM, 150);
    [tipLab sizeToFit];
    [self.view addSubview:tipLab];
    
    UIButton *confirmBtn = [UIButton btn];
    confirmBtn.normalTitle = ASLocalizedString(@"确认兑换");
    confirmBtn.frame = CGRectMake(30, tipLab.bottom + 80, kScreenW-2*30, 40);
    confirmBtn.normalBackgroundImage = [UIImage gradientImgWithView:confirmBtn];
    [confirmBtn addCorners:UIRectCornerAllCorners radius:confirmBtn.height*0.5];
    [self.view addSubview:confirmBtn];
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
