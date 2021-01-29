
#import "ASBackupWalletInputPSdVC.h"
#import "SXCodeTool.h"
@interface ASBackupWalletInputPSdVC ()
@property (weak, nonatomic) IBOutlet UIView *m_contentView;


@property (weak, nonatomic) IBOutlet UILabel *m_tipLab1;
@property (weak, nonatomic) IBOutlet UIButton *m_cancelBtn;
@end

@implementation ASBackupWalletInputPSdVC
- (void)dealloc {
    NSLog(@"--销毁页面--%@---", NSStringFromClass([self class]));
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        /// 淡入淡出
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_tipLab1.text = ASLocalizedString(@"钱包密码");
    self.m_cancelBtn.normalTitle = ASLocalizedString(@"取消");
    self.m_sureBtn.normalTitle = ASLocalizedString(@"确定");
    self.m_tf.placeholder = ASLocalizedString(@"请输入钱包密码");
    
    self.m_contentView.layer.cornerRadius = 8;
    self.m_tf.layer.cornerRadius = 8;
}
- (IBAction)clickCloseBtn {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
