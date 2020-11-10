//
//  ASFundCollectioinVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/6.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundCollectioinVC.h"
#import "UIButton+ImageTitleStyle.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
#import "ActionSheetPicker.h"


@interface ASFundCollectioinVC ()

@property (nonatomic, strong) UILabel *coinLab;

@end

@implementation ASFundCollectioinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    self.title = ASLocalizedString(@"收款");
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(kLeftRightM, kLeftRightM, kScreenW - 2 * kLeftRightM, 50)];
    topView.backgroundColor = @"#F7F7F7".hexColor;
    [self.view addSubview:topView];
    
    _coinLab = [UILabel m3b14Text:@"LAMB"];
    _coinLab.frame = CGRectMake(kLeftRightM, (topView.height - 20 )  / 2, 100, 20);
    [topView addSubview:_coinLab];
    
    UIButton *btn = [UIButton btn];
    btn.normalTitle = ASLocalizedString(@"选择币种");
    btn.titleLabel.font = [UIFont pFSize:15];
    btn.normalTitleColor = @"#959595".hexColor;
    [btn setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, topView.width - kLeftRightM - 8, topView.height);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [btn addTarget:self action:@selector(selectCoinType:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];
    
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(kLeftRightM, topView.bottom + kLeftRightM, kScreenW - 2 * kLeftRightM, 360)];
    midView.backgroundColor = @"#F7F7F7".hexColor;
    [self.view addSubview:midView];
    
    UIImageView *qrImageView = [[UIImageView alloc]initWithFrame:CGRectMake((midView.width - 140 ) / 2, 32, 140, 140)];
    qrImageView.image = [UIImage createImgQRCodeWithString:@"lambda98471239749127341" centerImage:[UIImage imageNamed:@"appIcon"]];
    [midView addSubview:qrImageView];
    
    UIButton *saveBtn = [UIButton btn];
    saveBtn.normalTitle = ASLocalizedString(@"保存二维码到相册");
    saveBtn.titleLabel.font = [UIFont pFSize:15];
    saveBtn.normalTitleColor = @"#3b3b3b".hexColor;
    saveBtn.frame = CGRectMake((midView.width - 180 ) / 2, qrImageView.bottom + 18, 180, 25);
    [saveBtn addCorner:25/2.0];
    [saveBtn addBorderWithWidth:1 borderColor:@"#3b3b3b".hexColor];
    [midView addSubview:saveBtn];
    
    UILabel *addressTipLab = [UILabel m9514Text:ASLocalizedString(@"账户地址")];
    addressTipLab.frame = CGRectMake(kLeftRightM, saveBtn.bottom + 18, midView.width - 2 * kLeftRightM, 20);
    addressTipLab.textAlignment = NSTextAlignmentCenter;
    [midView addSubview:addressTipLab];

    UILabel *addressLab = [UILabel m3b14Text:ASLocalizedString(@"lambda98471239749127341")];
    addressLab.frame = CGRectMake(kLeftRightM, addressTipLab.bottom + 18, midView.width - 2 * kLeftRightM, 20);
    addressLab.textAlignment = NSTextAlignmentCenter;
    [midView addSubview:addressLab];
    
    UIButton *copyBtn = [UIButton btn];
    copyBtn.normalTitle = ASLocalizedString(@"复制");
    copyBtn.titleLabel.font = [UIFont pFSize:15];
    copyBtn.normalTitleColor = @"#3b3b3b".hexColor;
    copyBtn.frame = CGRectMake((midView.width - 180 ) / 2, addressLab.bottom + 18, 180, 25);
    [copyBtn addCorner:25/2.0];
    [copyBtn addBorderWithWidth:1 borderColor:@"#3b3b3b".hexColor];
    [midView addSubview:copyBtn];
    
    
    UILabel *tipLab = [UILabel m3b14Text:ASLocalizedString(@"特别注意:\n1.请使用LAMB Wallet 扫码进行转账\n2.该二维码暂不支持非LAMB Wallet 扫描")];
    tipLab.font = [UIFont pFSize:14];
    tipLab.numberOfLines = 0;
    tipLab.frame = CGRectMake(kLeftRightM, midView.bottom + 2* kLeftRightM, topView.width, 70);
    [self.view addSubview:tipLab];
    
    
}

- (void) selectCoinType:(UIButton *) btn {
    
    NSArray *coinArray = @[@"LAMB",@"TBB"];
    NSInteger selectIndex = 0;
    kWeakSelf(weakSelf)
    if (![weakSelf.coinLab.text isEqualToString:[coinArray firstObject]]) {
        selectIndex = 1;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"" rows:coinArray initialSelection:selectIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        weakSelf.coinLab.text = selectedValue;
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:btn];
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
