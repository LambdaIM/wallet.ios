
#import "ASCustomNodeVC.h"
#import "NodeManager.h"
#import "SXCodeTool.h"
@interface ASCustomNodeVC ()
@property (weak, nonatomic) IBOutlet UIView *m_contentView;
@property (weak, nonatomic) IBOutlet UITextField *m_ipTF;
@property (weak, nonatomic) IBOutlet UITextField *m_portTF;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLab1;
@property (weak, nonatomic) IBOutlet UIButton *m_cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_sureBtn;

@end

@implementation ASCustomNodeVC
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
    
    self.m_tipLab1.text = ASLocalizedString(@"节点地址");
    self.m_cancelBtn.normalTitle = ASLocalizedString(@"取消");
    self.m_sureBtn.normalTitle = ASLocalizedString(@"确定");
    self.m_ipTF.placeholder = ASLocalizedString(@"请输入节点IP");

    self.m_contentView.layer.cornerRadius = 8;
    self.m_ipTF.layer.cornerRadius = 8;
    self.m_portTF.layer.cornerRadius = 8;
}
- (IBAction)clickCloseBtn {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)clickSureBtn {
    [NodeManager manager].type = ASNodeTypeCustom;
    if (self.refreshNodeBlock) {
        self.refreshNodeBlock();
    }
    [self dismissViewControllerAnimated:YES completion:NULL];

}
@end
