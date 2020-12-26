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

@interface KBTransferPledgeVC ()
@property(nonatomic, weak) TPKeyboardAvoidingScrollView *m_scroll;
@property (nonatomic, strong) NSArray *nodeListArray;    // 验证节点
@property (nonatomic, assign) NSInteger selectIndex; //
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
        [ASLabel text:lambAddress font:[UIFont pFSize:15] textColor:[UIColor blackColor]];
        lab.m_edgeInsets = UIEdgeInsetsMake(8, 16, 8, 16);
        lab.backgroundColor = grayColor;
        lab.numberOfLines = 0;
        [ms addSubview: lab];
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
    UIButton *tBtn = [UIButton btn];
    tBtn.normalTitle = ASLocalizedString(@"请选择转质押的节点");
    tBtn.normalTitleColor = [UIColor lightGrayColor];
    tBtn.normalImage = [UIImage imageNamed:@"drop_down"];
    tBtn.frame = CGRectMake(15, tipLab3.bottom + 10, kScreenW-2*15, 50);
    @weakify(self);
    [[tBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
                
        NSMutableArray *nodeTitleArray = [NSMutableArray array];
        
        for (ASNodeListModel *model in self.nodeListArray) {
            [nodeTitleArray addObject:[NSString stringWithFormat:@"%@...%@ %@",[model.operator_address substringToIndex:10],[model.operator_address substringFromIndex:model.operator_address.length - 6],model.descriptions.moniker]];
        }
        [ActionSheetStringPicker showPickerWithTitle:ASLocalizedString(@"请选择转质押的节点") rows:nodeTitleArray initialSelection:self.selectIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            [btn setTitle:[[selectedValue componentsSeparatedByString:@" "] firstObject] forState:UIControlStateNormal];
            [btn.titleLabel setTextColor:[UIColor blackColor]];
            [btn.titleLabel setFont:[UIFont pFSize:15]];
            btn.titleLabel.numberOfLines = 2;
            [btn setButtonImageTitleStyle:ButtonImageTitleStyleRightLeft padding:15];
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
        } origin:btn];
    }];
    [ms addSubview: tBtn];
    tBtn.backgroundColor = grayColor;
    tBtn.layer.cornerRadius = 8;
    [tBtn setButtonImageTitleStyle:ButtonImageTitleStyleRightLeft padding:15];
    
    UILabel *tipLab4 = ({
        UILabel *lab =
        [UILabel text:ASLocalizedString(@"金额(TBB)") font:[UIFont pFBlodSize:20] textColor:[UIColor blackColor]];
        [ms addSubview: lab];
        [lab sizeToFit];
        lab.top = tBtn.bottom +  10;
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
    
    UIButton *btn = [UIButton btn];
    btn.normalTitle = ASLocalizedString(@"确定");
    btn.frame = CGRectMake(30, tf.bottom + 50, kScreenW-2*30, 50);
    btn.normalBackgroundImage = [UIImage gradientImgWithView:btn];
    [btn addCorners:UIRectCornerAllCorners radius:btn.height*0.5];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        @strongify(self);
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

@end
