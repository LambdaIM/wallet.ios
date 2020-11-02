
#import "ASTableViewCell.h"

@implementation ASTableViewCell
- (void)config {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         [self config];
    }
    return  self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self config];
}

+(instancetype)cellFromTable:(UITableView *)table {
    ASTableViewCell *aCell = [table dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return aCell;
}
+(instancetype)cellFromTable:(UITableView *)table  forIndexPath:(NSIndexPath *)indexPath {
    ASTableViewCell *aCell = [table dequeueReusableCellWithIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    return aCell;
}
+(instancetype)xibCellFromTable:(UITableView *)table {
    NSString *str = NSStringFromClass(self);
    ASTableViewCell *cell = [table dequeueReusableCellWithIdentifier: str];
    if (cell == nil) {
         cell = [[[NSBundle mainBundle] loadNibNamed: str owner:nil options:nil] lastObject];
        UINib *cellNib = [UINib nibWithNibName:str bundle:nil];
        [table registerNib:cellNib forCellReuseIdentifier:str];
    }
    return cell;
}
@end
