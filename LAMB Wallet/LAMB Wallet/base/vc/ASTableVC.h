
@import UIKit;
#import "BaseVC.h"
NS_ASSUME_NONNULL_BEGIN
/// table vc
@interface ASTableVC : BaseVC<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong, readonly) UITableView *table;
/// 父类的数据容器
@property(nonatomic, strong, readonly) NSMutableArray *datas;
@end

NS_ASSUME_NONNULL_END
