//
//  KBMnemonicImportVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBMnemonicImportVC.h"
#import "UIView+Ex.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface KBMnemonicImportVC ()
// 钱包名称
@property (weak, nonatomic) IBOutlet UITextField *m_pname;
// 钱包密码
@property (weak, nonatomic) IBOutlet UITextField *m_pass;
// 确认密码
@property (weak, nonatomic) IBOutlet UITextField *m_conpass;

@property (weak, nonatomic) IBOutlet UIButton *m_confirmBtn;

@property (weak, nonatomic) IBOutlet UITextView *mnemonicTextView;
@end

@implementation KBMnemonicImportVC

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
    self.view.backgroundColor = @"ffffff".hexColor;
    
    self.mnemonicTextView.backgroundColor = @"F0F2F8".hexColor;
    self.mnemonicTextView.textContainerInset = UIEdgeInsetsMake(10,kLeftRightM, 10, kLeftRightM);
    [self.mnemonicTextView addCorner:30];
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = ASLocalizedString(@"助记词，用空格间隔");;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    [self.mnemonicTextView addSubview:placeHolderLabel];
 
    // same font
    [self.mnemonicTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];

    
    self.m_pname.backgroundColor = @"F0F2F8".hexColor; 
    self.m_pname.layer.cornerRadius = 24 ;
    self.m_pname.layer.masksToBounds = YES;
    self.m_pname.placeholder = ASLocalizedString(@"给你的钱包命名");
    [self configTextField:self.m_pname leftWidth:kLeftRightM];
    
    
    self.m_pass.backgroundColor = @"F0F2F8".hexColor;
    self.m_pass.layer.cornerRadius = 24 ;
    self.m_pass.layer.masksToBounds = YES;
    self.m_pass.placeholder = ASLocalizedString(@"6-20个字符、字母、数字或符号密码");
    [self configTextField:self.m_pass leftWidth:kLeftRightM];

    self.m_conpass.backgroundColor = @"F0F2F8".hexColor;
    self.m_conpass.layer.cornerRadius = 24 ;
    self.m_conpass.layer.masksToBounds = YES;
    self.m_conpass.placeholder = ASLocalizedString(@"确认密码");
    [self configTextField:self.m_conpass leftWidth:kLeftRightM];
    
    [self.m_confirmBtn maddSublayer];
    self.m_confirmBtn.layer.cornerRadius = 24;
    self.m_confirmBtn.layer.masksToBounds = YES;
    [self.m_confirmBtn.titleLabel sizeToFit];
}

#pragma mark 下一步
- (IBAction)OnClickNext:(UIButton *)sender {
    
    if (![[self.mnemonicTextView.text stringByTrim] isNotBlank]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"助记词错误，请核对后再次输入")];
        return;
    }
    
    NSArray *words = [[self.mnemonicTextView.text stringByTrim] componentsSeparatedByString:@" "];
    if (words.count != 24) {
        [ASHUD showHudTipStr:ASLocalizedString(@"助记词错误，请核对后再次输入")];
        return;
    }
    
    NSString *errorString = [LambUtils checkMnemonicWords:words];
    if (errorString) {
        [ASHUD showHudTipStr:[NSString stringWithFormat:@"%@ %@",ASLocalizedString(@"助记词错误"),errorString]];
        return;
    }
    
    if (![[self.m_pname.text stringByTrim] isNotBlank]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"请输入钱包名")];
        return;
    }
    if (![[self.m_pass.text stringByTrim] isNotBlank]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"请输入您的钱包密码")];
        return;
    }
    if (![[self.m_conpass.text stringByTrim]  isNotBlank]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"请再次确认密码")];
        return;
    }
    
    if (![[self.m_conpass.text  stringByTrim] isPSW]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"请设置6-20位，并且由字母，数字和符号两种以上组合的密码")];
        return;
    }
    
    if (![[self.m_conpass.text  stringByTrim] isEqualToString:[self.m_pass.text  stringByTrim]]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"两次密码不一致")];
        return;
    }
    
    if ([LambUtils getUserInfoWithUserName:[self.m_pname.text stringByTrim]]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"该钱包已存在")];
        return;
    }
    
    
    if ([LambUtils getUserInfoWithUserName:[self.m_pname.text stringByTrim]]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"该钱包已存在")];
        return;
    }else{
        [LambUtils shareInstance].currentUser.name = [self.m_pname.text stringByTrim];
        [LambUtils shareInstance].currentUser.password = [self.m_conpass.text stringByTrim];
        [LambUtils shareInstance].currentUser.mnemonic = words;
        
        [LambUtils creatMnemonicWithWords:[LambUtils shareInstance].currentUser.mnemonic];

        
        if ([LambUtils shareInstance].currentUser.address.length) {
            // 保存用户信息
            [LambUtils saveUserInfo:[LambUtils shareInstance].currentUser];
            [self.navigationController popToRootViewControllerAnimated:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WCS_USER_CHANGE_LANGUAGE" object:nil];
        }else{
            [ASHUD showHudTipStr:ASLocalizedString(@"地址错误")];
        }
    }
}

- (void) configTextField:(UITextField *) textField leftWidth:(CGFloat) leftWidth{
    // 输入框的左侧view
    UIView *paddingLeftView = [[UIView alloc] init];
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    paddingLeftView.frame = frame;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = paddingLeftView;
}

@end
