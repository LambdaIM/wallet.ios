//
//  ASTableVC.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN
/// 比较简单通用的table页面
@interface ASSimpleTableVC : BaseVC<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong, readonly) UITableView *table;
@property(nonatomic) NSArray<NSDictionary<NSString *, NSString *> *> *datas;

- (void) customTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
