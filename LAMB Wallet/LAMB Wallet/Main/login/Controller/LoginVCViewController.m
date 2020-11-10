//
//  LoginVCViewController.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "LoginVCViewController.h"
#import "KBCreatePocketVC.h"
#import "KBBipManager.h"

@interface LoginVCViewController ()
// 选择钱包
@property (weak, nonatomic) IBOutlet UIView *m_chooseView;
// 密码框的View
@property (weak, nonatomic) IBOutlet UIView *m_passView;
@property (weak, nonatomic) IBOutlet UITextField *m_passTextFild;
@property (weak, nonatomic) IBOutlet UIButton *m_loginBtn;

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
    self.m_chooseView.layer.cornerRadius = 6 ;
    self.m_chooseView.backgroundColor =@"F0F2F8".hexColor;
    self.m_passView.layer.cornerRadius = 6 ;
    self.m_passView.backgroundColor =@"F0F2F8".hexColor;
    self.m_passTextFild.backgroundColor = @"F0F2F8".hexColor;
    [self.m_loginBtn.layer addSublayer:[self addSublayer]];
    self.m_loginBtn.layer.cornerRadius = 24;
    self.m_loginBtn.layer.masksToBounds = YES;
    [self.m_loginBtn.titleLabel sizeToFit]; 
 }
 

-(CAGradientLayer *)addSublayer{
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, self.m_loginBtn.frame.size.width - 24 , self.m_loginBtn.frame.size.height);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.1),@(1.0)];
        [gradientLayer setColors:@[(id)[ @"5A95FC".hexColor CGColor],(id)[@"3757E2".hexColor CGColor]]];
    return gradientLayer;
}
#pragma mark 点击创建钱包
- (IBAction)OnCreateAction:(UIButton *)sender {
    KBCreatePocketVC *create = [[KBCreatePocketVC alloc] init];
    [self.navigationController push:create];
}

#pragma mark 导入钱包
- (IBAction)OnImportWallet:(UIButton *)sender { 
     
    NSString *mnemonicString =   [[KBBipManager manager] generateMnemonicString:@256 language:@"english" ];
    NSLog(@"====%@",mnemonicString);
}

@end
