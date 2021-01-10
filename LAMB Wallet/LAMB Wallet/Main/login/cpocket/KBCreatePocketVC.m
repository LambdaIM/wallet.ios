//
//  KBCreatePocketVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBCreatePocketVC.h"
#import "KBMnemonicVC.h"
#import "UIView+Ex.h"

@interface KBCreatePocketVC ()
// 钱包名称
@property (weak, nonatomic) IBOutlet UITextField *m_pname;
// 钱包密码
@property (weak, nonatomic) IBOutlet UITextField *m_pass;
// 确认密码
@property (weak, nonatomic) IBOutlet UITextField *m_conpass;

@property (weak, nonatomic) IBOutlet UIButton *m_confirmBtn;

@end

@implementation KBCreatePocketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = @"ffffff".hexColor;
    self.title = ASLocalizedString(@"创建钱包");
     
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
    }else{
        pushToDestinationController(self, KBMnemonicVC);
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
