//
//  ASFundTransferVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/6.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASFundTransferVC.h"
#import "ASTextField.h"
#import "UIButton+ImageTitleStyle.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
#import "ASFundTradRecordVC.h"
#import "ActionSheetPicker.h"
#import "OrderedDictionary.h"

@interface ASFundTransferVC ()

@property (nonatomic, strong) ASTextField *addressField;// 地址
@property (nonatomic, strong) ASTextField *amountField;// 数量
@property (nonatomic, strong) ASTextField *noteField;// 备注
@property (nonatomic, strong) UILabel *balanceLab;// 余额
@property (nonatomic, assign) NSInteger selelctIndex; //

@property (nonatomic, strong) ASSendTextSignModel *signModel;// 签名model
@property (nonatomic, strong) ASSendTextModel *sendModel;// 发送交易model
@end

@implementation ASFundTransferVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requstNodeDetail:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    self.title = ASLocalizedString(@"转账");
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton btn];
    [rightBtn setTitle:ASLocalizedString(@"交易记录") forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont pFSize:14];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn addTarget:self action:@selector(transferRecords) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightMenuItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightMenuItem];
    
    UILabel *receveAddresLab = [UILabel text:ASLocalizedString(@"接收方") font:[UIFont pFMediumSize:15] textColor:[UIColor blackColor]];
    receveAddresLab.frame = CGRectMake(kLeftRightM, kLeftRightM, kScreenW - 2 * kLeftRightM, 20);
    [self.view addSubview:receveAddresLab];
    
    _addressField = [[ASTextField alloc] initWithFrame:CGRectMake(kLeftRightM, receveAddresLab.bottom + 10, kScreenW-2*kLeftRightM, 50)];
    [self.view addSubview:_addressField];
    _addressField.m_leftMargin = 15;
    _addressField.layer.cornerRadius = 8;
    _addressField.placeholder = ASLocalizedString(@"lambda地址");
    _addressField.backgroundColor = @"#F1F2F7".hexColor;
    [self.view addSubview:_addressField];
    
    NSString *btnString = @"LAMB";
    if ([LambNodeManager manager].qrModel) {
        _addressField.text = [LambNodeManager manager].qrModel.address;
        if ([[LambNodeManager manager].qrModel.token isEqualToString:@"utbb"]) {
            self.selelctIndex = 1;
            btnString = @"TBB";
        }
    }
    
    NSString *balance = [self getbalanceString];
    
    UIButton *btn = [UIButton btn];
    [btn setTitle:btnString forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont pFMediumSize:15];
    [btn setImage:[UIImage imageNamed:@"drop_down"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(kLeftRightM + 6, _addressField.bottom + 10, 80, 20);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [btn addTarget:self action:@selector(changeCoinTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *balanceLab = [UILabel text:[NSString stringWithFormat:@"%@%@",ASLocalizedString(@"可用余额："),balance] font:[UIFont pFSize:14] textColor:[UIColor blackColor]];
    balanceLab.frame = CGRectMake(btn.right + kLeftRightM , btn.top, kScreenW - 2 * kLeftRightM - btn.right, 20);
    balanceLab.textAlignment = NSTextAlignmentRight;
    self.balanceLab = balanceLab;
    [self.view addSubview:balanceLab];
    
    _amountField = [[ASTextField alloc] initWithFrame:CGRectMake(kLeftRightM, btn.bottom + 10, kScreenW-2*kLeftRightM, 50)];
    [self.view addSubview:_amountField];
    _amountField.m_leftMargin = 15;
    _amountField.layer.cornerRadius = 8;
    _amountField.placeholder = ASLocalizedString(@"填写数额");
    _amountField.backgroundColor = @"#F1F2F7".hexColor;
    [self.view addSubview:_amountField];
    
    UILabel *noteTipLab = [UILabel text:ASLocalizedString(@"填写备注(可选)") font:[UIFont pFMediumSize:15] textColor:[UIColor blackColor]];
    noteTipLab.frame = CGRectMake(kLeftRightM, _amountField.bottom + 10, kScreenW - 2 * kLeftRightM, 20);
    [self.view addSubview:noteTipLab];
    
    _noteField = [[ASTextField alloc] initWithFrame:CGRectMake(kLeftRightM, noteTipLab.bottom + 10, kScreenW-2*kLeftRightM, 75)];
    [self.view addSubview:_noteField];
    _noteField.m_leftMargin = 15;
    _noteField.layer.cornerRadius = 8;
    _noteField.placeholder = ASLocalizedString(@"在此输入备注");
    _noteField.backgroundColor = @"#F1F2F7".hexColor;
    [self.view addSubview:_noteField];
    
    UIButton *confirmBtn = [UIButton btn];
    confirmBtn.normalTitle = ASLocalizedString(@"确认转账");
    confirmBtn.frame = CGRectMake(30, _noteField.bottom + 50, kScreenW-2*30, 50);
    confirmBtn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [confirmBtn addCorners:UIRectCornerAllCorners radius:confirmBtn.height*0.5];
    [confirmBtn addTarget:self action:@selector(confirmTransfer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
}
/// 交易币对切换
/// @param btn 按钮
- (void) changeCoinTypeClick:(UIButton *) btn {
    
    NSArray *coinArray = @[@"LAMB",@"TBB"];
    __block UIButton *tempBtn = btn;
    kWeakSelf(weakSelf)
    [ActionSheetStringPicker showPickerWithTitle:@"" rows:coinArray initialSelection:self.selelctIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        weakSelf.selelctIndex = selectedIndex;
        weakSelf.balanceLab.text = [NSString stringWithFormat:@"%@%@",ASLocalizedString(@"可用余额："),[self getbalanceString]];
        [tempBtn setTitle:selectedValue forState:UIControlStateNormal];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:btn];
}
/// 右上角划转记录
- (void) transferRecords {
    pushToDestinationController(self, ASFundTradRecordVC);
}

- (void) confirmTransfer{
    if (![self.addressField.text isNotBlank]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"请输入接收方的地址")];
        return;
    }
    if ([self.amountField.text isNotBlank] && [self.amountField.text doubleValue] > 0) {
    }else{
        [ASHUD showHudTipStr:ASLocalizedString(@"请输入金额")];
        return;
    }
    if ([self.addressField.text isEqualToString:[LambUtils shareInstance].currentUser.address]) {
        [ASHUD showHudTipStr:ASLocalizedString(@"不支持转账给本人")];
        return;
    }
//
    [self requstNodeDetail:YES];
}

- (void)extracted:(id)requestObj {
    [LambNetManager POST:getHTTP_Get_transaction_detail parameters:requestObj showHud:YES success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/// 获取节点信息
- (void) requstNodeDetail:(BOOL) transfer{
    
    kWeakSelf(weakSelf)
    dispatch_queue_t queue = dispatch_queue_create("lambSerialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        if (![LambNodeManager manager].currentNodeInfo) {
            [LambNetManager GET:HTTP_Get_chain_details parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    
                    ASNodeInfoModel *infoModel = [ASNodeInfoModel yy_modelWithDictionary:responseObject];
                    [LambNodeManager manager].currentNodeInfo = infoModel;
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
            
            [LambNetManager GET:JoinParam(USER_Get_Auth, [LambUtils shareInstance].currentUser.address) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    ASAssertModel *nodeDetail = [ASAssertModel yy_modelWithDictionary:responseObject];
                    [LambNodeManager manager].assertModel = nodeDetail;
                }else{

                }
            } failure:^(NSError * _Nonnull error) {

            }];
        }
        if (transfer) {
            // 获取 Gas
            ASSendTextGasModel *gasModel = [[ASSendTextGasModel alloc]init];
            gasModel.to_address = [self.addressField.text stringByTrim];
            gasModel.base_req.sequence = [LambNodeManager manager].assertModel.value.sequence;
            gasModel.base_req.account_number = [LambNodeManager manager].assertModel.value.account_number;
            if ([self.noteField.text isNotBlank]) {
                gasModel.base_req.memo = self.noteField.text;
            }else{
                self.noteField.text = @"";
            }
            gasModel.base_req.chain_id = [LambNodeManager manager].currentNodeInfo.network;
            
            ASSendAmountModel *amountModel = [[ASSendAmountModel alloc]init];
            amountModel.amount = [[self.amountField.text stringByTrim] requestShowNumber:@"0"];
            if (self.selelctIndex == 0) {
                amountModel.denom = @"ulamb";
            }else{
                amountModel.denom = @"utbb";
            }
            
            NSArray *amountArray = [NSArray arrayWithObject:amountModel];
            gasModel.amount = amountArray;
            
            // 签名消息体
            self.signModel.chain_id = gasModel.base_req.chain_id;
            self.signModel.account_number = gasModel.base_req.account_number;
            self.signModel.sequence = gasModel.base_req.sequence;
            self.signModel.memo = gasModel.base_req.memo;
            self.signModel.fee.amount = amountArray;
            
            ASSendMsgModel *msgModel = [[ASSendMsgModel alloc] init];
            msgModel.value.to_address = gasModel.to_address;
            msgModel.value.amount = [NSArray arrayWithArray:amountArray];
            NSArray *msgArray = [NSArray arrayWithObject:msgModel];
            self.signModel.msgs = msgArray;
            
            // 发送消息体
            self.sendModel.tx.memo = self.signModel.memo;
            self.sendModel.tx.msg = self.signModel.msgs;
            
            
            __block ASSendSignaturesModel *signAtures = [[ASSendSignaturesModel alloc]init];
            
            
            NSArray *signArray = [NSArray arrayWithObject:signAtures];
            self.sendModel.tx.signatures = signArray;
            
            [LambNetManager POST:JoinParam(getHTTP_Get_transaction_Gas, [LambUtils shareInstance].currentUser.address) parameters:[gasModel modelToJSONObject] showHud:NO success:^(id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    weakSelf.signModel.fee.gas = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"gas_estimate"]];
                    weakSelf.sendModel.tx.fee = weakSelf.signModel.fee;
                    
                    NSDictionary *signDic = [weakSelf.signModel modelToJSONObject];
                    
                    NSString *signString = [LambUtils dictionaryToJson:signDic];
                    
                    NSMutableString * str3 = [[NSMutableString alloc]initWithString:signString];
                    
                    [str3 replaceOccurrencesOfString:@"\\" withString:@"" options:1 range:NSMakeRange(0, str3.length)];

                    NSString *signModelString = [LambUtils signatureForHash:str3];
                    
//                    NSString *signString = [LambUtils signatureForHash:[weakSelf.signModel yy_modelToJSONString]];
                    signAtures.signature = signModelString;
                    
                    id requestObj = [weakSelf.sendModel modelToDictionary];
                    
                    NSLog(@"签名后的数据 %@ \n 签名字符串 %@ \n 发送请求%@",signModelString,str3,responseObject);

                    // 发送交易请求
                    [weakSelf extracted:requestObj];
                }
            } failure:^(NSError * _Nonnull error) {
                [ASHUD showHudTipStr:ASLocalizedString(@"交易失败")];
            }];
        }
    });
}

- (NSString *) getbalanceString {
    NSString *balanceString = @"0";
    if (self.selelctIndex == 0) {
        for (ASProposalValueAmountModel *model in [LambNodeManager manager].assertModel.value.coins) {
            if ([model.denom isEqualToString:@"ulamb"]) {
                balanceString = [model.amount getShowNumber:@"6"];
                break;
            }
        }
    }else{
        for (ASProposalValueAmountModel *model in [LambNodeManager manager].assertModel.value.coins) {
            if ([model.denom isEqualToString:@"utbb"]) {
                balanceString = [model.amount getShowNumber:@"6"];
                break;
            }
        }
    }
    return balanceString;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
