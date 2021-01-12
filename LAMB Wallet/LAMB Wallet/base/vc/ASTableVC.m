
#import "ASTableVC.h"

@interface ASTableVC ()
@property(nonatomic, strong, readwrite) UITableView *table;
@property(nonatomic, strong, readwrite) NSMutableArray *datas;

@end

@implementation ASTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.table];
    self.datas = @[].mutableCopy;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH - kll_Status_NavBarHeight - kll_SafeBottomMargin);
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = self.datas.count;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [UITableViewCell new];
    return cell;
}
#pragma mark - getter and setter
- (UITableView *)table
{
    if (!_table) {
        
        UITableView *table =  [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain];
        _table = table;
        table.dataSource = self;
        table.delegate = self;
        table.tableFooterView = [UIView new];
        table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        table.separatorInset = UIEdgeInsetsZero;
        table.showsVerticalScrollIndicator = NO;
        table.separatorColor = @"#E6E6E6".hexColor;
        table.backgroundColor = self.view.backgroundColor;
    }
    return _table;
}
@end
