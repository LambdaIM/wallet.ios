
#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN
/// 自定义节点
@interface ASCustomNodeVC : UIViewController
@property(nonatomic, copy) void (^refreshNodeBlock)(void);
@end

NS_ASSUME_NONNULL_END
