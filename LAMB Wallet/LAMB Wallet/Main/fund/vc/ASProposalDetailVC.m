//
//  ASProposalDetailVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/15.
//  Copyright © 2020 fei. All rights reserved.
//
#define kTEST_KEY_CACHE NO

#import "ASProposalDetailVC.h"
@import MJRefresh;
#import "ASProposalDetailCell.h"
#import <UITableViewDynamicLayoutCacheHeight/UITableViewDynamicLayoutCacheHeight.h>

@interface ASProposalDetailVC ()

@end

@implementation ASProposalDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    self.title = ASLocalizedString(@"提案详情");
    [self.table registerNib:[UINib nibWithNibName:@"ASProposalDetailCell" bundle:nil] forCellReuseIdentifier:@"ASProposalDetailCell"];
    self.table.mj_footer.hidden = YES;
    self.table.separatorStyle = UITableViewCellAccessoryNone;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASProposalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASProposalDetailCell"];
    if (self.model) {
        cell.model = self.model;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (kTEST_KEY_CACHE) {
        return [tableView bm_heightWithCellClass:ASProposalDetailCell.class cacheByKey:indexPath.description configuration:^(__kindof ASProposalDetailCell *cell) {
            if (self.model) {
                cell.model = self.model;
            }
        }];
    } else {
        return [tableView bm_heightWithCellClass:ASProposalDetailCell.class cacheByIndexPath:indexPath configuration:^(__kindof ASProposalDetailCell *cell) {
            if (self.model) {
                cell.model = self.model;
            }
        }];
    }
}

-(void)loadDataAtPage:(NSInteger)page {
    
    kWeakSelf(weakSelf);
    
    [self.datas removeAllObjects];
    [self.datas addObject:self.model];
    [weakSelf.table reloadData];
    if (self.model) {
        [LambNetManager GET:getHTTP_Get_proposal_parameters parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
            ASProposalValueAmountModel *minModel = [ASProposalValueAmountModel yy_modelWithDictionary:[[responseObject objectForKey:@"min_deposit"] firstObject]];
            weakSelf.model.min_deposit = minModel;
            weakSelf.model.max_deposit_period = [responseObject objectForKey:@"max_deposit_period"];
            [weakSelf.table reloadData];
        } failure:^(NSError * _Nonnull error) {

        }];

        [LambNetManager GET:JoinParams(getHTTP_Get_proposal_my_yajin, self.model.ids, lambAddress) parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
            [weakSelf.table reloadData];
        } failure:^(NSError * _Nonnull error) {
            
        }];

        [LambNetManager GET:JoinParams(getHTTP_Get_proposal_my_toupiao, self.model.ids,lambAddress) parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
            [weakSelf.table reloadData];
        } failure:^(NSError * _Nonnull error) {

        }];

        [LambNetManager GET:JoinParam(getHTTP_Get_proposal_toupiao, self.model.ids) parameters:@{} showHud:YES success:^(id  _Nonnull responseObject) {
            [weakSelf.table reloadData];
        } failure:^(NSError * _Nonnull error) {

        }];
    }
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
