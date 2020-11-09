//
//  ASFundTransferVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/6.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundTransferVC.h"
#import "ASTextField.h"
#import "UIButton+ImageTitleStyle.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
#import "ASFundTradRecordVC.h"

@interface ASFundTransferVC ()

@property (nonatomic, strong) ASTextField *addressField;// 地址
@property (nonatomic, strong) ASTextField *amountField;// 数量
@property (nonatomic, strong) ASTextField *noteField;// 备注

@end

@implementation ASFundTransferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    self.title = ASLocalizedString(@"转账");
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton btn];
    [rightBtn setTitle:ASLocalizedString(@"交易记录") forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont pFSize:14];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn addTarget:self action:@selector(transferRecords) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightMenuItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightMenuItem];
    
    UILabel *receveAddresLab = [UILabel text:ASLocalizedString(@"接收方") font:[UIFont pFMediumSize:15] textColor:[UIColor blackColor]];
    receveAddresLab.frame = CGRectMake(kLeftRightM, kLeftRightM, kScreenW - 2 * kLeftRightM, 20);
    [self.view addSubview:receveAddresLab];
    
    _addressField = [[ASTextField alloc] initWithFrame:CGRectMake(kLeftRightM, receveAddresLab.bottom + 10, kScreenW-2*kLeftRightM, 50)];
    [self.view addSubview:_addressField];
    _addressField.m_leftMargin = 15;
    _addressField.layer.cornerRadius = 8;
    _addressField.placeholder = ASLocalizedString(@"lambda地址");
    _addressField.backgroundColor = @"#F1F2F7".hexColor;
    [self.view addSubview:_addressField];
    
    UIButton *btn = [UIButton btn];
    [btn setTitle:@"LAMB" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont pFMediumSize:15];
    [btn setImage:[UIImage imageNamed:@"drop_down"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(kLeftRightM + 6, _addressField.bottom + 10, 80, 20);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [btn addTarget:self action:@selector(changeCoinTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *balanceLab = [UILabel text:[NSString stringWithFormat:@"%@%@",ASLocalizedString(@"可用余额:"),@"99,999.3242"] font:[UIFont pFSize:14] textColor:[UIColor blackColor]];
    balanceLab.frame = CGRectMake(kScreenW - 180 - kLeftRightM, btn.top, 180, 20);
    balanceLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:balanceLab];
    
    _amountField = [[ASTextField alloc] initWithFrame:CGRectMake(kLeftRightM, btn.bottom + 10, kScreenW-2*kLeftRightM, 50)];
    [self.view addSubview:_amountField];
    _amountField.m_leftMargin = 15;
    _amountField.layer.cornerRadius = 8;
    _amountField.placeholder = ASLocalizedString(@"填写数额");
    _amountField.backgroundColor = @"#F1F2F7".hexColor;
    [self.view addSubview:_amountField];
    
    UILabel *noteTipLab = [UILabel text:ASLocalizedString(@"填写备注（可选）") font:[UIFont pFMediumSize:15] textColor:[UIColor blackColor]];
    noteTipLab.frame = CGRectMake(kLeftRightM, _amountField.bottom + 10, kScreenW - 2 * kLeftRightM, 20);
    [self.view addSubview:noteTipLab];
    
    _noteField = [[ASTextField alloc] initWithFrame:CGRectMake(kLeftRightM, noteTipLab.bottom + 10, kScreenW-2*kLeftRightM, 75)];
    [self.view addSubview:_noteField];
    _noteField.m_leftMargin = 15;
    _noteField.layer.cornerRadius = 8;
    _noteField.placeholder = ASLocalizedString(@"在此输入备注");
    _noteField.backgroundColor = @"#F1F2F7".hexColor;
    [self.view addSubview:_noteField];
    
    UIButton *confirmBtn = [UIButton btn];
    confirmBtn.normalTitle = ASLocalizedString(@"确认转账");
    confirmBtn.frame = CGRectMake(30, _noteField.bottom + 50, kScreenW-2*30, 50);
    confirmBtn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [confirmBtn addCorners:UIRectCornerAllCorners radius:confirmBtn.height*0.5];
    [self.view addSubview:confirmBtn];
    
}
/// 交易币对切换
/// @param btn 按钮
- (void) changeCoinTypeClick:(UIButton *) btn {
    
}
/// 右上角划转记录
- (void) transferRecords {
    pushToDestinationController(self, ASFundTradRecordVC);
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
