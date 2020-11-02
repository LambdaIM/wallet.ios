
#import "ASTableVC.h"

NS_ASSUME_NONNULL_BEGIN
/// 自带上下拉刷新 vc
@interface ASRefreshVC : ASTableVC<UITableViewDataSource>
@property (nonatomic, assign ,readwrite) NSInteger current_page;
/// 结束header footer刷新
- (void)endRefresh;
/// 子类重写些方法进行网络请求
- (void)loadDataAtPage:(NSInteger)page;
/// 收到了数据
/// @param dicts 字典数组
/// @param page 获取的是哪一页，直接传loadDataAtPage的参数page
/// @param resPageNum 服务器返回的当前页数
/// @param resPageSize 服务器返回的一页加载多少个
/// @param objClass 要转换的模型
- (void)receivedDicts:(id)dicts atPage:(NSInteger)page resPageNum:(id)resPageNum resPageSize:(id)resPageSize  objClass:(Class)objClass;
@end

NS_ASSUME_NONNULL_END
/* loadDataAtPage 模板
 
 - (void)loadDataAtPage:(NSInteger)page {
    
     
     
     NSMutableDictionary *paramters = [[NSMutableDictionary alloc] init];
     paramters[@"pageNumber"] = @(page);
     paramters[@"pageSize"] = @20;
     
     [MARequestEngine queryNewersListDataWithParamers:paramters success:^(id  _Nullable dataObj, NSString * _Nullable msg) {
     

         [self endRefresh];
         
         [super receivedDicts: dataObj[@"datas"]
                      atPage: page
                  resPageNum: dataObj[@"pageNumber"]
                 resPageSize: dataObj[@"pageSize"]
                    objClass: [MAExperienceZone class]];
     } failure:^(NSString * _Nullable msg) {
          [self endRefresh];
         [self showHudTipStr:msg];
     }];
 }

 
 */
