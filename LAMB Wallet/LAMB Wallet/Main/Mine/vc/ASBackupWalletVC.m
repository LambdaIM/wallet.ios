
#import "ASBackupWalletVC.h"

#import "SXCodeTool.h"
#import "ASLabel.h"
@interface ASBackupWalletVC ()
@property (weak, nonatomic) IBOutlet UIView *m_contentView;
@property (weak, nonatomic) IBOutlet UILabel *m_tipLab1;
@property (weak, nonatomic) IBOutlet UILabel *m_tipLab2;
@property (weak, nonatomic) IBOutlet ASLabel *m_keyLab;

@property (weak, nonatomic) IBOutlet UIButton *m_cancelBtn;
@end

@implementation ASBackupWalletVC
-(NSString *)m_keyString {
    return self.m_keyLab.text;
}
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
    
    self.m_keyLab.m_edgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    self.m_tipLab1.text = ASLocalizedString(@"备份钱包");
    self.m_tipLab2.text = ASLocalizedString(@"提示：请点击复制，在PC端生成txt文件保存内容，然后修改后缀为keyinfo即可");
    self.m_cancelBtn.normalTitle = ASLocalizedString(@"取消");
    self.m_sureBtn.normalTitle = ASLocalizedString(@"复制");
    
    self.m_contentView.layer.cornerRadius = 8;
}
- (IBAction)clickCloseBtn {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
