//
//  ASFundTradRecordVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/15.
//  Copyright © 2020 fei. All rights reserved.
//
#define kTEST_KEY_CACHE NO

#import "ASProposalsVC.h"
@import MJRefresh;
#import "ASProposalsCell.h"
#import <UITableViewDynamicLayoutCacheHeight/UITableViewDynamicLayoutCacheHeight.h>


@interface ASProposalsVC ()

@end

@implementation ASProposalsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
        
    [self requestDetail:@"1"];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    self.title = ASLocalizedString(@"提案");
//    self.table.rowHeight = 80;
    [self.table registerNib:[UINib nibWithNibName:@"ASProposalsCell" bundle:nil] forCellReuseIdentifier:@"ASProposalsCell"];
    self.table.separatorStyle = UITableViewCellAccessoryNone;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASProposalsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASProposalsCell"];
    if (self.datas.count) {
        cell.model = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (kTEST_KEY_CACHE) {
            return [tableView bm_heightWithCellClass:ASProposalsCell.class cacheByKey:indexPath.description configuration:^(__kindof ASProposalsCell *cell) {
                // 配置 Cell
                // 同 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 一样
                if (self.datas.count) {
                    cell.model = [self.datas objectAtIndex:indexPath.row];
                }
            }];
        } else {
            return [tableView bm_heightWithCellClass:ASProposalsCell.class cacheByIndexPath:indexPath configuration:^(__kindof ASProposalsCell *cell) {
                // 配置 Cell
                // 同 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 一样
                if (self.datas.count) {
                    cell.model = [self.datas objectAtIndex:indexPath.row];
                }
            }];
        }
    
}

-(void)loadDataAtPage:(NSInteger)page {
    
    kWeakSelf(weakSelf)
    [LambNetManager GET:getHTTP_Get_proposal_list parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
        [self receivedDicts:responseObject atPage:page resPageNum:[NSString stringWithFormat:@"1"] resPageSize:@100 objClass:[ASProposalModel class]];
    } failure:^(NSError * _Nonnull error) {
        self.table.mj_footer.hidden = self.datas.count < 20;
        [weakSelf endRefresh];
    }];
}

- (void) requestDetail:(NSString *) detailId {
    [LambNetManager GET:JoinParam(getHTTP_Get_proposal_details, detailId) parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
