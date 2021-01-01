//
//  KBPledgeVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBPledgeVC.h"
@import TPKeyboardAvoiding;
#import "UIView+Ex.h"
#import "SXCodeTool.h"
#import "ASLabel.h"
#import "ASTextField.h"
#import "UIImage+Ex.h"
@interface KBPledgeVC ()
@property(nonatomic, weak) TPKeyboardAvoidingScrollView *m_scroll;

@end

@implementation KBPledgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshUIRealTime];
    if (self.m_cancel) {
        self.title = ASLocalizedString(@"取消质押");
    } else {
        self.title = ASLocalizedString(@"质押");
    }
    
    
    TPKeyboardAvoidingScrollView *ms = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:ms];
    ms.backgroundColor = [UIColor whiteColor];
    self.m_scroll = ms;
    ms.contentSize = CGSizeMake(kScreenW, kScreenH);
    
    UILabel *tipLab1 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"发送方") font:[UIFont pFBlodSize:20] textColor:[UIColor blackColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.top = 10;
        lab.left = 15;
        lab;
    });
    UILabel *valuelab1 = ({
        ASLabel *lab =
        [ASLabel text:lambAddress font:[UIFont pFSize:15] textColor:[UIColor blackColor]];
        lab.m_edgeInsets = UIEdgeInsetsMake(8, 16, 8, 16);
        lab.backgroundColor = @"#F1F2F7".hexColor;
        lab.numberOfLines = 0;
        lab.layer.cornerRadius = 8;
        lab.clipsToBounds = YES;
        [ms addSubview: lab];
        lab.top = tipLab1.bottom + 10;
        lab.left = 15;
        lab.width = kScreenW-2*15;
        [lab sizeToFit];
        lab;
    });
    
    UILabel *tipLab2 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"接收方") font:[UIFont pFBlodSize:20] textColor:[UIColor blackColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.top = valuelab1.bottom +  10;
        lab.left = 15;
        lab;
    });
    UILabel *valuelab2 = ({
        ASLabel *lab =
        [ASLabel text:self.nodeDetailModel.operator_address font:[UIFont pFSize:15] textColor:[UIColor blackColor]];
        lab.m_edgeInsets = UIEdgeInsetsMake(8, 16, 8, 16);
        lab.backgroundColor = @"#F1F2F7".hexColor;
        lab.numberOfLines = 0;
        [ms addSubview: lab];
        lab.layer.cornerRadius = 8;
        lab.clipsToBounds = YES;
        lab.top = tipLab2.bottom + 10;
        lab.left = 15;
        lab.width = kScreenW-2*15;
        [lab sizeToFit];
        lab;
    });
    
    UILabel *tipLab3 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"金额（TBB）") font:[UIFont pFBlodSize:20] textColor:[UIColor blackColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.top = valuelab2.bottom +  10;
        lab.left = 15;
        lab;
    });
    // 可用余额
    UILabel *valueLabCan = ({
        UILabel *lab =
        [UILabel text:self.m_cancel ? [NSString stringWithFormat:@"%@ TBB",self.nodeDetailModel.utbb.length > 0 ? [self.nodeDetailModel.utbb getShowNumber:@"6"]:@"0"] :@"0TBB" font:[UIFont pFSize:15] textColor:[UIColor orangeColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.centerY = tipLab3.centerY;
        lab.right = kScreenW- 15;
        lab;
    });
    UILabel *tipLabCan = ({
        NSString *str = self.m_cancel ? ASLocalizedString(@"质押金额：") : ASLocalizedString(@"可用余额：");
        UILabel *lab =
        [UILabel text:ASLocalizedString(str) font:[UIFont pFSize:15] textColor:[UIColor blackColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.centerY = tipLab3.centerY;
        lab.right = valueLabCan.left;
        lab;
    });
    
    ASTextField *tf = [[ASTextField alloc] initWithFrame:CGRectMake(15, tipLab3.bottom + 10, kScreenW-2*15, 50)];
    [ms addSubview:tf];
    tf.m_leftMargin = 15;
    if (self.m_cancel) {
        tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }else{
        tf.keyboardType = UIKeyboardTypeNumberPad;
    }
    tf.layer.cornerRadius = 8;
    tf.placeholder = ASLocalizedString(@"填写数额");
    tf.backgroundColor = @"#F1F2F7".hexColor;
    
    UIButton *btn = [UIButton btn];
    btn.normalTitle = ASLocalizedString(@"确定");
    btn.frame = CGRectMake(30, tf.bottom + 50, kScreenW-2*30, 50);
    btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [btn addCorners:UIRectCornerAllCorners radius:btn.height*0.5];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
    }];
    [ms addSubview:btn];
    if (self.m_cancel) {
        // 在确定按钮上追加提示文本
        UILabel *valuelab2 = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString(@"特别注意：\n1:21.00天内只能取消质押7笔,取消质押后将不再发放奖励\n2:解除质押周期内，节点被惩罚了，解除质押的币也会按照惩罚比例进行扣除\n3:解质押等待时间:21.00天，期间不发放收益") font:[UIFont pFSize:13] textColor:[UIColor redColor]];
            [ms addSubview: lab];
            lab.numberOfLines = 0;
            lab.width = kScreenW - 2*15;
            lab.top = tf.bottom + 10;
            lab.left = 15;
            [lab sizeToFit];
            lab;
        });
        
        btn.top = valuelab2.bottom + 50;
    }
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.m_scroll.frame = self.view.bounds;
}
@end
