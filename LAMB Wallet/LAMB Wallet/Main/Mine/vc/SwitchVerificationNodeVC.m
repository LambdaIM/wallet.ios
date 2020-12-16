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
#import "FCAlertView.h"
#import <NSDictionary+YYAdd.h>
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
    
    NSArray *nodes = [NodeManager loadNodes];
    NSMutableArray *datas = [NSMutableArray array];
    for (ASNodeModel *model in nodes) {
        [datas addObject:@{@"title":model.nodeName, @"sel":@"selectAtindex", @"selected":@(model.select)}];
    }
    self.datas = datas;
}
- (void)clickCustomNodeBtn {
    ASCustomNodeVC *vc = [ASCustomNodeVC new];
    __weak __typeof(self)weakSelf = self;
    vc.refreshNodeBlock = ^(NSString * _Nonnull nodeAddress) {
        if (nodeAddress) {
            ASNodeModel *nodeModel = [[ASNodeModel alloc]initWithBaseUrl:[[nodeAddress componentsSeparatedByString:@":"]firstObject] port:[[nodeAddress componentsSeparatedByString:@":"]lastObject] nodeName:nodeAddress select:YES];
            [NodeManager addNode:nodeModel];
            [weakSelf configModel:nodeModel];
        }
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

- (void)customTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *nodes = [NodeManager loadNodes];
    ASNodeModel *selectModel = [nodes objectAtIndex:indexPath.row];
    [self configModel:selectModel];
}

- (void) configModel:(ASNodeModel *) model {
    NSArray *nodes = [NodeManager loadNodes];
    for (int i = 0; i < nodes.count; i ++) {
        ASNodeModel *tempModel = [nodes objectAtIndex:i];
        if ([model.baseUrl isEqualToString:tempModel.baseUrl]) {
            tempModel.select = YES;
        }else{
            tempModel.select = NO;
        }
    }
    [[NodeManager manager] configNode:model];
    [NodeManager addNodes:nodes];
    [self loadData];
    [self.table reloadData];
    
    [self requstNodeDetail];
}


- (void) requstNodeDetail{
    
    [LambNetManager GET:HTTP_Get_chain_details parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
        
        FCAlertView *alert = [[FCAlertView alloc] init];

        [alert showAlertWithTitle:ASLocalizedString(@"节点信息")
                  withSubtitle:[responseObject jsonStringEncoded]
               withCustomImage:nil
           withDoneButtonTitle:ASLocalizedString(@"确认")
                    andButtons:nil];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
