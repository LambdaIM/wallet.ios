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

static CGFloat accountTableViewCellHeight = 50;

@interface LoginVCViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ASUserModel *selelctUserModel;
}
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

@property (nonatomic, strong) UITableView *accountTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;

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
    
    [self.view addSubview:self.accountTableView];
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
- (IBAction)selectAccountBtn:(UIButton *)sender {
    
    if (!self.dataArray.count) {
        [ASHUD showHudTipStr:ASLocalizedString(@"本地暂无钱包")];
    }else{
        sender.selected = !sender.selected;
        
        self.accountTableView.height = (self.dataArray.count > 6 ? 6 :self.dataArray.count) *accountTableViewCellHeight;
        if (sender.selected) {
            self.accountTableView.hidden = NO;
        }else{
            self.accountTableView.hidden = YES;
        }
        [self.accountTableView reloadData];
    }
}

#pragma mark 用户登录
- (IBAction)loginBtnClice:(UIButton *)sender {
    if (selelctUserModel) {
        if ([[self.paswordField.text stringByTrim] isEqualToString:selelctUserModel.password]) {
            if (selelctUserModel.mnemonic) {
                [LambUtils shareInstance].currentUser = selelctUserModel;
                [LambUtils creatMnemonicWithWords:selelctUserModel.mnemonic];
                if (selelctUserModel.address.length) {
                    // 保存用户信息
                    [LambUtils saveUserInfo:[LambUtils shareInstance].currentUser];
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"WCS_USER_CHANGE_LANGUAGE" object:nil];
                }else{
                    [ASHUD showHudTipStr:ASLocalizedString(@"地址错误")];
                }
            }
        }
    }
}

- (UITableView *)accountTableView {
    if (!_accountTableView) {
        _accountTableView = [[UITableView alloc]initWithFrame:CGRectMake(40, 265, kScreenW - 2 * 40, (self.dataArray.count > 6 ? 6 :self.dataArray.count) *accountTableViewCellHeight) style:UITableViewStylePlain];
        _accountTableView.delegate = self;
        _accountTableView.dataSource = self;
        _accountTableView.hidden = YES;
    }
    return _accountTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return accountTableViewCellHeight;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"LambdaAccountUITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (self.dataArray.count) {
        ASUserModel *userModel = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [userModel.address showLambAddress];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ASUserModel *userModel = [self.dataArray objectAtIndex:indexPath.row];
    self.accountNameField.text = [userModel.address showLambAddress];
    selelctUserModel = userModel;
    self.accountTableView.hidden = YES;
    self.accountBtn.selected = NO;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray){
        _dataArray = [NSMutableArray array];
        for (NSString *userName in [LambUtils shareInstance].localUserNames) {
            ASUserModel *model = [LambUtils getUserInfoWithUserName:userName];
            if (model) {
                [_dataArray addObject:model];
            }
        }
    }
    return _dataArray;
}
@end
