//
//  WCSGoogleVerifyView.m
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/28.
//  Copyright © 2019 WCSCoin. All rights reserved.
//

#import "ASVerifyPasswordView.h"
#import "ASTextField.h"

@interface ASVerifyPasswordView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *centerView;
/// 短信验证码，提示字
@property(nonatomic, strong) UILabel *smsCodeTipLab;
@property (nonatomic, strong) UILabel *titleLab; // 标题
@property (nonatomic, strong) UILabel *tipLab; // 提示标签

@property (nonatomic, strong) UILabel *gasLab; // 费用lab

@property (nonatomic, strong) UIButton *confirmBtn;
@property(nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) ASTextField *password; // 密码
@end

@implementation ASVerifyPasswordView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgView];
        [self addSubview:self.centerView];
    }
    return self;
}

- (UIView *)centerView {
    
    if (!_centerView) {
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(kLeftRightM, (kScreenH - AUTOSIZEIPHONE6(258) ) / 2, kScreenW - 2 * kLeftRightM, AUTOSIZEIPHONE6(258))];
        [_centerView addBorderWithWidth:0.5 borderColor:[UIColor grayColor]];
        [_centerView addCorner:10];
        _centerView.backgroundColor = [UIColor whiteColor];

        _tipLab = [UILabel ms3b14Text:ASLocalizedString(@"钱包密码")];
        _tipLab.frame = CGRectMake(kLeftRightM+10, 0, _centerView.width - 2 * kLeftRightM, AUTOSIZEIPHONE6(45));
        [_centerView addSubview: _tipLab];

        _password = [[ASTextField alloc]initWithFrame:CGRectMake(kLeftRightM,_tipLab.bottom + 5, _centerView.width - 2 * kLeftRightM, AUTOSIZEIPHONE6(45))];
        _password.placeholder = ASLocalizedString(@"请输入钱包密码");
        _password.secureTextEntry = YES;
        [_password addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _password.tintColor = [UIColor blackColor];
        [_centerView addSubview:_password];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kLeftRightM, _password.bottom + 10, _centerView.width - 2 * kLeftRightM, AUTOSIZEIPHONE6(45))];
        bgView.backgroundColor = [UIColor mBaseViewColor];
        [bgView addCorner:5];
        [_centerView addSubview:bgView];
        
        _titleLab = [UILabel m3b14Text:ASLocalizedString(@"GAS费用(LAMB)：")];
        _titleLab.frame = CGRectMake(kLeftRightM, 0, bgView.width - 2 * kLeftRightM, bgView.height);
        [bgView addSubview: _titleLab];
        
        _gasLab = [UILabel m3b14Text:@""];
        _gasLab.textAlignment = NSTextAlignmentRight;
        _gasLab.textColor = [UIColor mGasColor];
        _gasLab.frame = CGRectMake(kLeftRightM, 0, bgView.width - 2 * kLeftRightM, bgView.height);
        
        [bgView addSubview: _gasLab];
        
        UIView *bottomLine = [UIView creatLineView];
        bottomLine.frame = CGRectMake(0, bgView.bottom + 20, _centerView.width, 0.4);
        [_centerView addSubview:bottomLine];
        
         //取消按钮
        UIButton *cancleBtn = [UIButton creatButton:CGRectMake(0, bottomLine.bottom, _centerView.width / 2, AUTOSIZEIPHONE6(40)) title:ASLocalizedString(@"取消") titleColor:[UIColor grayColor] titleFont:16 target:self action:@selector(buttonCLick:) tag:100];
        [_centerView addSubview:cancleBtn];
        self.cancleBtn = cancleBtn;

        UIView *bottomVerLine = [UIView creatLineView];
        bottomVerLine.frame = CGRectMake(cancleBtn.right, cancleBtn.top, 0.4, cancleBtn.height);
        [_centerView addSubview:bottomVerLine];

        _confirmBtn = [UIButton creatButton:CGRectMake(cancleBtn.right, cancleBtn.top, cancleBtn.width, cancleBtn.height) title:ASLocalizedString(@"确认") titleColor:[UIColor blueColor] titleFont:16 target:self action:@selector(buttonCLick:) tag:101];
        [_centerView addSubview:_confirmBtn];
        _confirmBtn.enabled = NO;
        _centerView.frame = CGRectMake(kLeftRightM, (kScreenH - _confirmBtn.bottom ) / 2 - 100, kScreenW - 2 * kLeftRightM, _confirmBtn.bottom);
    }
    return _centerView;
}


- (UIView *)bgView{
    
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    }

    _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];

    return _bgView;
}

- (void)textFieldDidChange:(UITextField *) textField{
    
    if (self.password.text.length > 0) {
        self.confirmBtn.enabled = YES;
    }else{
        self.confirmBtn.enabled = NO;
    }
}

- (void)buttonCLick:(UIButton *) btn {
    
    if (btn.tag == 100) {
        [self dismiss];
    }else{
        if ([self.password.text isEqualToString:[LambUtils shareInstance].currentUser.password]) {
            [self dismiss];
            if (self.confirmPassword) {
                self.confirmPassword(YES);
            }
        }else{
            [ASHUD showHudTipStr:ASLocalizedString(@"密码错误")];
        }
    }
}

+ (ASVerifyPasswordView *)factoryWCSGoogleVerifyView {
    
    ASVerifyPasswordView *tempView = [[ASVerifyPasswordView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    return tempView;
}

- (void)showWihtType:(NSString *)verifyType gas:(NSString *)gas{
    
    kWeakSelf(weakSelf)
    self.password.text = @"";
    
    self.titleLab.text = [NSString stringWithFormat:@"GAS%@(%@):",ASLocalizedString(@"费用"),verifyType];
    self.gasLab.text = [gas getShowNumber:@"6"];
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self];
    
    NSUInteger delaySecond = 0.25;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySecond * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf.password becomeFirstResponder];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}

- (void)dismiss {
    [self removeFromSuperview];
}



@end
