//
//  LoginVCViewController.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "LoginVCViewController.h"
#import "KBCreatePocketVC.h"
#import "KBImportPocketVC.h"
#import "UIView+Ex.h"

@interface LoginVCViewController ()
// 选择钱包
@property (weak, nonatomic) IBOutlet UIView *m_chooseView;
// 密码框的View
@property (weak, nonatomic) IBOutlet UIView *m_passView;
@property (weak, nonatomic) IBOutlet UITextField *m_passTextFild;
@property (weak, nonatomic) IBOutlet UIButton *m_loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountNameField;
@property (weak, nonatomic) IBOutlet UITextField *paswordField;
@property (weak, nonatomic) IBOutlet UIButton *creatBtn;// 创建
@property (weak, nonatomic) IBOutlet UIButton *loadingBtn;// 导入
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation LoginVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideNav = YES;
    [self initView];
}

/**
   初始化View
 */
-(void)initView{
    self.m_chooseView.layer.cornerRadius = 45/2.0 ;
    self.m_chooseView.backgroundColor =@"F0F2F8".hexColor;
    self.m_passView.layer.cornerRadius = 45/2.0;
    self.m_passView.backgroundColor =@"F0F2F8".hexColor;
    self.m_passTextFild.backgroundColor = @"F0F2F8".hexColor;
    [self.m_loginBtn maddSublayer];
    self.m_loginBtn.layer.cornerRadius = 24;
    self.m_loginBtn.layer.masksToBounds = YES;
    [self.m_loginBtn.titleLabel sizeToFit];
    
    self.accountNameField.placeholder = ASLocalizedString(@"请选择钱包");
    self.paswordField.placeholder = ASLocalizedString(@"请输入密码");
 }
 
#pragma mark 点击创建钱包
- (IBAction)OnCreateAction:(UIButton *)sender {
    KBCreatePocketVC *create = [[KBCreatePocketVC alloc] init];
    [self.navigationController push:create];
}

#pragma mark 导入钱包
- (IBAction)OnImportWallet:(UIButton *)sender { 
     
    KBImportPocketVC *create = [[KBImportPocketVC alloc] init];
    [self.navigationController push:create];
}
#pragma mark 选择账户
- (IBAction)selectAccountBtn:(id)sender {
    
}

@end
