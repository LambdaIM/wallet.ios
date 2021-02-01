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
#import "ASVerifyPasswordView.h"
#import "ASProposalModel.h"

@interface KBPledgeVC ()<UITextFieldDelegate>
@property(nonatomic, weak) TPKeyboardAvoidingScrollView *m_scroll;
@property (nonatomic, strong) UILabel *valueLabCan;
@property (nonatomic, strong) UILabel *tipLabCan;
@property (nonatomic, strong) ASSendTextSignModel *signModel;
@property (nonatomic, strong) ASSendTextModel *sendModel;
@property (nonatomic, strong) ASTextField *tf;

@end

@implementation KBPledgeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.m_cancel) {
        kWeakSelf(weakSelf)
        [self getaAssertComplain:^(ASAssertModel *assertModel) {
            
            for (ASProposalValueAmountModel *model in assertModel.value.coins) {
                if ([model.denom isEqualToString:@"utbb"]) {
                    NSString *coinName = [[[model.denom componentsSeparatedByString:@"u"] lastObject] uppercaseString];
                    weakSelf.valueLabCan.text = [NSString stringWithFormat:@"%@ %@",[model.amount getShowNumber:@"6"],coinName];
                    [weakSelf.valueLabCan sizeToFit];
                    weakSelf.valueLabCan.right = kScreenW - kLeftRightM;
                    weakSelf.tipLabCan.right = weakSelf.valueLabCan.left;

                    break;
                }
            }
        }];
    }
}

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
        [ASLabel text:[LambUtils shareInstance].currentUser.address font:[UIFont pFSize:15] textColor:[UIColor blackColor]];
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
    self.valueLabCan = valueLabCan;
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
    self.tipLabCan = tipLabCan;
    
    ASTextField *tf = [[ASTextField alloc] initWithFrame:CGRectMake(15, tipLab3.bottom + 10, kScreenW-2*15, 50)];
    tf.delegate = self;
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
    self.tf = tf;
    
    UIButton *btn = [UIButton btn];
    btn.normalTitle = ASLocalizedString(@"确定");
    btn.frame = CGRectMake(30, tf.bottom + 50, kScreenW-2*30, 50);
    btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [btn addCorners:UIRectCornerAllCorners radius:btn.height*0.5];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        if ([self.tf.text isNotBlank] && [self.tf.text doubleValue] >= 1) {
            if (self.m_cancel) {
                // 取消质押
                if ([[self.nodeDetailModel.utbb getShowNumber:@"6"] floatValue] >= [self.tf.text floatValue]) {
                    [self getLambGas];
                }else{
                    [ASHUD showHudTipStr:ASLocalizedString(@"余额不足")];
                }
            }else{
                // 质押
                [self getLambGas];
            }
        }
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


- (void) getLambGas{

    kWeakSelf(weakSelf)
    
    // 获取节点信息
    [LambNetManager GET:HTTP_Get_chain_details parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            ASNodeInfoModel *infoModel = [ASNodeInfoModel yy_modelWithDictionary:responseObject];
            [LambNodeManager manager].currentNodeInfo = infoModel;
            
            NSLog(@"111111111");

            // 获取资产信息
            [LambNetManager GET:JoinParam(USER_Get_Auth, [LambUtils shareInstance].currentUser.address) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    ASAssertModel *nodeDetail = [ASAssertModel yy_modelWithDictionary:responseObject];
                    [LambNodeManager manager].assertModel = nodeDetail;

                    NSLog(@"2222222222");
                    
                        // 获取 Gas
                        __block ASSendLockTBBGasModel *gasModel = [[ASSendLockTBBGasModel alloc]init];
                        gasModel.base_req.sequence = [LambNodeManager manager].assertModel.value.sequence;
                        gasModel.base_req.account_number = [LambNodeManager manager].assertModel.value.account_number;
                        gasModel.base_req.memo = @"";
                        gasModel.base_req.chain_id = [LambNodeManager manager].currentNodeInfo.network;
                        gasModel.amount.amount = [[self.tf.text stringByTrim] requestShowNumber:@"0"];
                        gasModel.amount.denom = @"utbb";
                        gasModel.validator_address = weakSelf.nodeDetailModel.operator_address;
                        NSString *gasString = [gasModel modelToJSONObject];
                        NSLog(@"gas:%@",gasString);

                        // 获取Gas 费用
                    [LambNetManager POST:JoinParam(self.m_cancel?getHTTP_Get_unbonding_delegations_Lamb_Gas:getHTTP_Get_delegations_Lamb_Gas, [LambUtils shareInstance].currentUser.address) parameters:gasString showHud:YES success:^(id  _Nonnull responseObject) {
                            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                
                                NSString *finalGasString = [NSString stringWithFormat:@"%.0f",[[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"gas_estimate"]] doubleValue] * 1.2];
                                NSLog(@"--------%@", finalGasString);

                                self.signModel.fee.gas = finalGasString;
                                
                                // gas价格 写死
                                ASSendAmountModel *amountModel = [[ASSendAmountModel alloc]init];
                                amountModel.amount = TX_GAS_DEFINE;
                                amountModel.denom = @"ulamb";
                                NSArray *amountArray = [NSArray arrayWithObject:amountModel];
                                
                                // 签名消息体
                                weakSelf.signModel.chain_id = gasModel.base_req.chain_id;
                                weakSelf.signModel.account_number = gasModel.base_req.account_number;
                                weakSelf.signModel.sequence = gasModel.base_req.sequence;
                                weakSelf.signModel.memo = gasModel.base_req.memo;
                                weakSelf.signModel.fee.amount = amountArray;
                                
                                // 质押消息
                                NSMutableArray *nodeListMsg = [NSMutableArray array];
                                
                                ASSendLockTBBMsgTxtModel *lockMessage = [[ASSendLockTBBMsgTxtModel alloc] init];
                                
                                if (self.m_cancel) {
                                    lockMessage.type = CANCELZHIYA;
                                }
                                
                                lockMessage.value.validator_address = weakSelf.nodeDetailModel.operator_address;
                                lockMessage.value.amount.amount = [[self.tf.text stringByTrim] requestShowNumber:@"0"];
                                [nodeListMsg addObject:lockMessage];
                                
                                weakSelf.signModel.msgs = nodeListMsg;

                                weakSelf.sendModel.tx.fee = weakSelf.signModel.fee;

                                // 发送消息体
                                weakSelf.sendModel.tx.memo = weakSelf.signModel.memo;
                                weakSelf.sendModel.tx.msg = weakSelf.signModel.msgs;

                                __block ASSendSignaturesModel *signAtures = [[ASSendSignaturesModel alloc]init];

                                NSArray *signArray = [NSArray arrayWithObject:signAtures];
                                weakSelf.sendModel.tx.signatures = signArray;

                                // 签名的数据
                                NSDictionary *signDic = [weakSelf.signModel modelToJSONObject];

                                NSString *signString = [LambUtils dictionaryToJson:signDic];

                                NSMutableString * str3 = [[NSMutableString alloc]initWithString:signString];

                                [str3 replaceOccurrencesOfString:@"\\" withString:@"" options:1 range:NSMakeRange(0, str3.length)];

                                NSString *signModelString = [LambUtils signatureForHash:str3];

                                signAtures.signature = signModelString;

                                __block id requestObj = [weakSelf.sendModel modelToDictionary];

                                NSLog(@"发送交易签名后的数据： %@ \n 签名字符串： %@ \n 发送请求：%@",signModelString,str3,[requestObj yy_modelToJSONString]);
                                NSLog(@"33333333");

                                dispatch_async(dispatch_get_main_queue(), ^{
                                    ASVerifyPasswordView *passwrodView = [ASVerifyPasswordView factoryWCSGoogleVerifyView];

                                    [passwrodView showWihtType:@"LAMB" gas:weakSelf.sendModel.tx.fee.gas];
                                    passwrodView.confirmPassword = ^(BOOL state) {
                                        if (state) {
                                            // 发送交易请求
                                            [weakSelf extracted:requestObj];
                                        }
                                    };
                                });

                            }
                        } failure:^(NSError * _Nonnull error) {
                            [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
                        }];
                }else{
                    [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
                }
            } failure:^(NSError * _Nonnull error) {
                [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
    }];
}

/// 发送交易
/// @param requestObj 签名对象
- (void)extracted:(id)requestObj {
    
    kWeakSelf(weakSelf)
    
    [LambNetManager POST:getHTTP_Get_transaction_detail parameters:requestObj showHud:YES success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject containsObjectForKey:@"logs"]) {
                
                NSArray *logArray = [ASSendLogModel modelsWithJSON:[responseObject objectForKey:@"logs"]];
                BOOL state = YES;
                for (ASSendLogModel *tempModel in logArray) {
                    if (!tempModel.success) {
                        state = NO;
                        break;
                    }
                }
                if (!state) {
                    [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
                }else{
                    // 刷新余额
                    [ASHUD showHudTipStr:ASLocalizedString(@"操作成功,正在刷新账户信息,请稍候")];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
            }
        }else{
            [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
        }
    } failure:^(NSError * _Nonnull error) {
        [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
    }];
}

- (ASSendTextSignModel *)signModel {
    if (!_signModel) {
        _signModel = [[ASSendTextSignModel alloc] init];
    }
    return _signModel;
}

- (ASSendTextModel *)sendModel {
    if (!_sendModel) {
        _sendModel = [[ASSendTextModel alloc] init];
    }
    return _sendModel;
}

// 获取资产详情
- (void) getaAssertComplain:(void(^)(ASAssertModel *assertModel)) complain{
    
    kWeakSelf(weakSelf)
    [LambNetManager GET:JoinParam(USER_Get_Auth, [LambUtils shareInstance].currentUser.address) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ASAssertModel *nodeDetail = [ASAssertModel yy_modelWithDictionary:responseObject];
            [LambNodeManager manager].assertModel = nodeDetail;
            complain(nodeDetail);
        }else{
            complain(nil);
        }
    } failure:^(NSError * _Nonnull error) {
        complain(nil);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    return [self validateNumber:string];
}
 
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
         NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
         NSRange range = [string rangeOfCharacterFromSet:tmpSet];
         if (range.length == 0) {
            res = NO;
            break;
          }
          i++;
       }
    return res;
}

@end
