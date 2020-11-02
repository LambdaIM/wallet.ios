
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASTableViewCell : UITableViewCell

+(instancetype)cellFromTable:(UITableView *)table;
+(instancetype)cellFromTable:(UITableView *)table forIndexPath:(NSIndexPath *)indexPath;
+(instancetype)xibCellFromTable:(UITableView *)table;
@end

NS_ASSUME_NONNULL_END
