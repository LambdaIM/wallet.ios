//
//  KBCreatePocketVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBCreatePocketVC.h"

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
    
    
    
    
    
    [self.m_confirmBtn.layer addSublayer:[self addSublayer]];
    self.m_confirmBtn.layer.cornerRadius = 24;
    self.m_confirmBtn.layer.masksToBounds = YES;
    [self.m_confirmBtn.titleLabel sizeToFit];
}

 
-(CAGradientLayer *)addSublayer{
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, self.m_confirmBtn.frame.size.width - 24 , self.m_confirmBtn.frame.size.height);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.1),@(1.0)];
        [gradientLayer setColors:@[(id)[ @"5A95FC".hexColor CGColor],(id)[@"3757E2".hexColor CGColor]]];
    return gradientLayer;
}
@end
