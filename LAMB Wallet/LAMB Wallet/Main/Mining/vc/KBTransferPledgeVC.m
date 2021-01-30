//
//  KBTransferPledgeVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBTransferPledgeVC.h"
@import TPKeyboardAvoiding;
#import "UIView+Ex.h"
#import "SXCodeTool.h"
#import "ASLabel.h"
#import "ASTextField.h"
#import "UIImage+Ex.h"
#import "UIButton+ImageTitleStyle.h"
#import "ActionSheetStringPicker.h"
#import "ASVerifyPasswordView.h"

@interface KBTransferPledgeVC ()
@property(nonatomic, weak) TPKeyboardAvoidingScrollView *m_scroll;
@property (nonatomic, strong) NSArray *nodeListArray;    // 验证节点
@property (nonatomic, assign) NSInteger selectIndex; //
@property (nonatomic, strong) UILabel *nodeActionLab;    // <#des#>
@property (nonatomic, strong) ASSendTextSignModel *signModel;
@property (nonatomic, strong) ASSendTextModel *sendModel;

@property (nonatomic, strong) ASTextField *tf;
@end

@implementation KBTransferPledgeVC

- (void)viewWillAppear:(BOOL)animated {
    [self getCanUserNodeDate];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshUIRealTime];
  
    self.title = ASLocalizedString(@"转质押");
    
    
    
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
    UIColor *grayColor = @"#F1F2F7".hexColor;
    UILabel *valuelab1 = ({
        ASLabel *lab =
        [ASLabel text:[LambUtils shareInstance].currentUser.address font:[UIFont pFSize:15] textColor:[UIColor blackColor]];
        lab.m_edgeInsets = UIEdgeInsetsMake(8, 16, 8, 16);
        lab.backgroundColor = grayColor;
        lab.numberOfLines = 0;
        [ms addSubview: lab];
        lab.layer.cornerRadius = 8;
        lab.clipsToBounds = YES;
        lab.top = tipLab1.bottom + 10;
        lab.left = 15;
        lab.width = kScreenW-2*15;
        [lab sizeToFit];
        lab;
    });
    
    UILabel *tipLab2 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"旧节点") font:[UIFont pFBlodSize:20] textColor:[UIColor blackColor]];
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
        lab.backgroundColor = grayColor;
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
    // 转质押节点
    UILabel *tipLab3 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"转质押节点") font:[UIFont pFBlodSize:20] textColor:[UIColor blackColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.top = valuelab2.bottom +  10;
        lab.left = 15;
        lab;
    });
    
    
    self.nodeActionLab = ({
        ASLabel *lab =
        [ASLabel text:self.nodeDetailModel.operator_address font:[UIFont pFSize:15] textColor:[UIColor lightGrayColor]];
        lab.m_edgeInsets = UIEdgeInsetsMake(8, 16, 8, 30);
        lab.backgroundColor = grayColor;
        lab.numberOfLines = 2;
        [ms addSubview: lab];
        lab.layer.cornerRadius = 8;
        lab.clipsToBounds = YES;
        lab.top = tipLab3.bottom + 10;
        lab.left = 15;
        lab.width = kScreenW-2*15;
        [lab sizeToFit];
        lab;
    });
    
    UIImage *icon = [UIImage imageNamed:@"drop_down"] ;
    
    UIImageView *dropImageView = [[UIImageView alloc]initWithImage:icon];
    dropImageView.frame = CGRectMake(self.nodeActionLab.width - icon.size.width - 15, (self.nodeActionLab.height - icon.size.height ) / 2, icon.size.width, icon.size.height);
    [self.nodeActionLab addSubview:dropImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectNodeAction)];
    self.nodeActionLab.userInteractionEnabled = YES;
    dropImageView.userInteractionEnabled = YES;
    [self.nodeActionLab addGestureRecognizer:tap];
    
    @weakify(self);
    
    UILabel *tipLab4 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"金额（TBB）") font:[UIFont pFBlodSize:20] textColor:[UIColor blackColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.top = self.nodeActionLab.bottom +  10;
        lab.left = 15;
        lab;
    });
    
    ASTextField *tf = [[ASTextField alloc] initWithFrame:CGRectMake(15, tipLab4.bottom + 10, kScreenW-2*15, 50)];
    [ms addSubview:tf];
    tf.m_leftMargin = 15;
    tf.layer.cornerRadius = 8;
    tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    tf.placeholder = ASLocalizedString(@"填写数额");
    tf.backgroundColor = grayColor;
    self.tf = tf;
    
    UIButton *btn = [UIButton btn];
    btn.normalTitle = ASLocalizedString(@"确定");
    btn.frame = CGRectMake(30, tf.bottom + 50, kScreenW-2*30, 50);
    btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [btn addCorners:UIRectCornerAllCorners radius:btn.height*0.5];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
        if ([self.tf.text isNotBlank] && [self.tf.text doubleValue] >= 1) {
            // 转质押
            if ([[self.nodeDetailModel.utbb getShowNumber:@"6"] floatValue] >= [self.tf.text floatValue]) {
                
                if (![self.nodeActionLab.text isNotBlank] &&![self.nodeActionLab.text isEqualToString:ASLocalizedString(@"请选择转质押的节点")]) {
                    [ASHUD showHudTipStr:ASLocalizedString(@"请选择转质押的节点")];
                }else{
                    [self getLambGas];
                }
            }else{
                [ASHUD showHudTipStr:ASLocalizedString(@"余额不足")];
            }
        }
    }];
    [ms addSubview:btn];
        // 在确定按钮上追加提示文本
        UILabel *redTip = ({
            UILabel *lab =
            [UILabel text:ASLocalizedString(@"特别注意：\n1:21.00天内只能转质押7笔,且不能从新节点再转出\n2:转质押周期内，原节点被惩罚了，转质押的币仍会按照惩罚比例进行扣除") font:[UIFont pFSize:13] textColor:[UIColor redColor]];
            [ms addSubview: lab];
            lab.numberOfLines = 0;
            lab.width = kScreenW - 2*15;
            lab.top = tf.bottom + 10;
            lab.left = 15;
            [lab sizeToFit];
            lab;
        });
        
        btn.top = redTip.bottom + 50;
    
    self.nodeActionLab.text = [NSString stringWithFormat:@"%@",ASLocalizedString(@"请选择转质押的节点")] ;
}

- (void) selectNodeAction {
    
    // 选择地址弹窗
    NSMutableArray *nodeTitleArray = [NSMutableArray array];

    kWeakSelf(weakSelf)
    
    for (ASNodeListModel *model in self.nodeListArray) {
        [nodeTitleArray addObject:[NSString stringWithFormat:@"%@...%@ %@",[model.operator_address substringToIndex:10],[model.operator_address substringFromIndex:model.operator_address.length - 6],model.descriptions.moniker]];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:ASLocalizedString(@"请选择转质押的节点") rows:nodeTitleArray initialSelection:self.selectIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        weakSelf.nodeActionLab.textColor = [UIColor blackColor];
        weakSelf.selectIndex = selectedIndex;
        ASNodeListModel *model = [weakSelf.nodeListArray objectAtIndex:selectedIndex];
        weakSelf.nodeActionLab.text = model.operator_address;
    } cancelBlock:^(ActionSheetStringPicker *picker) {

    } origin:self.nodeActionLab];
}

- (void) getCanUserNodeDate {
    
    kWeakSelf(weakSelf)
    // 获取可用节点
    [LambNetManager GET:JoinParam(HTTP_Get_producers, @"bonded") parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            weakSelf.nodeListArray = [NSArray yy_modelArrayWithClass:[ASNodeListModel class] json:responseObject];
        }
    } failure:^(NSError * _Nonnull error) {

    }];
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
                        __block ASSendReLockTBBGasModel *gasModel = [[ASSendReLockTBBGasModel alloc]init];
                        gasModel.base_req.sequence = [LambNodeManager manager].assertModel.value.sequence;
                        gasModel.base_req.account_number = [LambNodeManager manager].assertModel.value.account_number;
                        gasModel.base_req.memo = @"";
                        gasModel.base_req.chain_id = [LambNodeManager manager].currentNodeInfo.network;
                        gasModel.amount.amount = [[self.tf.text stringByTrim] requestShowNumber:@"0"];
                        gasModel.amount.denom = @"utbb";
                        gasModel.validator_src_address = weakSelf.nodeDetailModel.operator_address;
                    
                        ASNodeListModel *newNodel = [weakSelf.nodeListArray objectAtIndex:weakSelf.selectIndex];
                        gasModel.validator_dst_address = newNodel.operator_address;

                        NSString *gasString = [gasModel modelToJSONObject];
                        NSLog(@"gas:%@",gasString);

                        // 获取Gas 费用
                    [LambNetManager POST:JoinParam(getHTTP_Get_redelegations_Lamb_Gas, [LambUtils shareInstance].currentUser.address) parameters:gasString showHud:YES success:^(id  _Nonnull responseObject) {
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
                                
                                ASSendReLockTBBMsgTxtModel *lockMessage = [[ASSendReLockTBBMsgTxtModel alloc] init];
                                
                                
                                lockMessage.value.validator_src_address = weakSelf.nodeDetailModel.operator_address;
                                lockMessage.value.validator_dst_address = gasModel.validator_dst_address;
                                
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

@end
