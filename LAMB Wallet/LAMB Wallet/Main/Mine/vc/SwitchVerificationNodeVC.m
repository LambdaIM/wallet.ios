//
//  ASLanguageVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "SwitchVerificationNodeVC.h"
#import "ASCheckCell.h"
#import "NodeManager.h"
#import "ASCustomNodeVC.h"
@interface SwitchVerificationNodeVC ()

@end

@implementation SwitchVerificationNodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.rowHeight = 55;
    self.title = ASLocalizedString(@"切换验证节点");
    [self.table registerNib:[UINib nibWithNibName:@"ASCheckCell" bundle:nil] forCellReuseIdentifier:@"ASCheckCell"];

    [self loadData];
    [self.table reloadData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:ASLocalizedString(@"自定义") style:UIBarButtonItemStylePlain target:self action:@selector(clickCustomNodeBtn)];
}
- (void)loadData {
    BOOL b1 = NO;
    BOOL b2 = NO;
    if ([NodeManager manager].type == ASNodeTypeMain) {
        b1 = YES;
        b2 = NO;
    } else if ([NodeManager manager].type == ASNodeTypeTest) {
        b1 = NO;
        b2 = YES;
    } else {
        // 自定义
    }
    
    self.datas = @[@{@"title":ASLocalizedString(@"主网默认节点"), @"sel":@"SwitchToMainnetDefaultNode", @"selected":@(b1)},
                   @{@"title":ASLocalizedString(@"测试网默认节点"), @"sel":@"SwitchToTestnetDefaultNode", @"selected":@(b2)}];
}
- (void)clickCustomNodeBtn {
    ASCustomNodeVC *vc = [ASCustomNodeVC new];
    __weak __typeof(self)weakSelf = self;
    vc.refreshNodeBlock = ^{
        [weakSelf loadData];
        [weakSelf.table reloadData];
    };
    [self presentViewController:vc animated:YES completion:NULL];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCheckCell *cell = [ASCheckCell cellFromTable:tableView];
    NSDictionary *dict = self.datas[indexPath.row];
    cell.m_lab.text = dict[@"title"];
    cell.m_btn.selected = [dict[@"selected"] boolValue];
    return cell;
}

- (void)SwitchToMainnetDefaultNode {
    [NodeManager manager].type = ASNodeTypeMain;
    [self loadData];
    [self.table reloadData];
}
- (void)SwitchToTestnetDefaultNode {
    [NodeManager manager].type = ASNodeTypeTest;
    [self loadData];
    [self.table reloadData];

}
@end
