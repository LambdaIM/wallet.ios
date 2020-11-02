
#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN
/// 备份钱包弹窗
@interface ASBackupWalletVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *m_sureBtn;

@property(nonatomic, copy, readonly) NSString *m_keyString;
@end

NS_ASSUME_NONNULL_END
