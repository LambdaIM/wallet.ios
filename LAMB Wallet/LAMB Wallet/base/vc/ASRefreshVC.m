

#import "ASRefreshVC.h"
#import <MJRefresh/MJRefresh.h>
#import <YYModel/NSObject+YYModel.h>
@import DZNEmptyDataSet;
@interface ASRefreshVC ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@end

@implementation ASRefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.emptyDataSetSource = self;
    self.table.emptyDataSetDelegate = self;
    self.current_page = 1;
    [self setupRefreshHeader];
    [self setupRefreshFooter];
    [self loadDataAtPage: self.current_page];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = self.datas.count;
    if (count == 0) {
        self.table.mj_footer.hidden = YES;
    }
    return count;
}

#pragma mark -  上下拉刷新
#pragma mark  刷新控件
- (void)setupRefreshHeader
{
    @weakify(self)
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self loadDataAtPage: 1];
    }];
    
    if (!self.table.mj_header) {
        [self loadDataAtPage: 1];
    }
}

- (void)setupRefreshFooter{
    @weakify(self)
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self loadDataAtPage:self.current_page + 1];
    }];
}

- (void)endRefresh
{
    if (self.table.mj_header.isRefreshing) {
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    
    [self.table.mj_footer endRefreshing];
}
#pragma mark - 刷新
- (void)loadDataAtPage:(NSInteger)page {
    
}

- (void)receivedDicts:(id)dicts atPage:(NSInteger)page resPageNum:(id)resPageNum resPageSize:(id)resPageSize  objClass:(Class)objClass {

    NSArray *objs = [NSArray yy_modelArrayWithClass:objClass json:dicts];
    if ([self isFirstPage: resPageNum]) {
        [self.datas removeAllObjects];
    }
    if (objs.count > 0) {
        self.current_page = page;
    }
    self.table.mj_footer.hidden = (objs.count < [resPageSize integerValue]);
    [self.datas addObjectsFromArray: objs];
    [self.table reloadData];
}
- (BOOL)isFirstPage:(id)resPageNum {
    if ([resPageNum isKindOfClass:[NSNumber class]] && [resPageNum isEqual: @1]) {
        return YES;
    }
    else if ([resPageNum isKindOfClass:[NSString class]] &&
             [resPageNum isEqualToString: @"1"]) {
        
        return YES;
    }
    return NO;
}
#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed: @"image_wujilu"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无数据";
    UIFont *font = [UIFont systemFontOfSize:16 weight: UIFontWeightMedium];
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
//    return 8;
//}
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
//{
//
//    CGFloat imgH = 174;
//    CGFloat labH = 20;
//    CGFloat imgLabMarin = 8;
//    CGFloat showH = imgH + labH + imgLabMarin;
//    CGFloat topMarin = 57;
//    CGFloat offsetH = (kll_MAINHEIGHT) * 0.5 - topMarin - showH *0.5;
//    return -self.table.tableHeaderView.frame.size.height/2.0f-offsetH+28+topMarin;;
//}
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return  YES;
}
@end
