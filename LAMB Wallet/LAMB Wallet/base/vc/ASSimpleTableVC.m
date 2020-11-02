//
//  ASTableVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASSimpleTableVC.h"

@interface ASSimpleTableVC ()
@property(nonatomic, strong, readwrite) UITableView *table;
@end

@implementation ASSimpleTableVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.table.frame = self.view.bounds;
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.datas[indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:[dict[@"UITableViewCellStyle"] integerValue] reuseIdentifier:[NSString stringWithFormat:@"%zd%@", indexPath.row, @"cell"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = [dict[@"UITableViewCellAccessoryType"] integerValue];
    cell.textLabel.text = dict[@"title"];
    cell.detailTextLabel.text = dict[@"detail"];

    [self configCell:cell img:dict[@"imgName"]];

    return cell;
}
- (void)configCell:(UITableViewCell *)cell img:(NSString *)imgName {
    if (imgName.length > 0) {
        UIImage *img = [UIImage imageNamed: imgName];
        if (img) {
            cell.imageView.image = img;
        }
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self callSEL:self.datas[indexPath.row][@"sel"]];
}
- (void)callSEL:(NSString *)selStr {
    if (selStr.length <= 0) {
        return;
    }
    SEL selector = NSSelectorFromString(selStr);
    if (!selector) {
        return;
    }
    ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
}
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
        table.separatorColor = @"#E6E6E6".hexColor;
        table.backgroundColor = self.view.backgroundColor;
    }
    return _table;
}
@end
