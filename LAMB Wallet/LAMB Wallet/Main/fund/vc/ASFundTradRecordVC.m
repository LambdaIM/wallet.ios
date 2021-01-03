//
//  ASFundTradRecordVC.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/9.
//  Copyright © 2020 fei. All rights reserved.
//
//  交易记录列表
#import "ASFundTradRecordVC.h"
@import MJRefresh;
#import "ASFundTradRecordCell.h"

#import "ASRecordListModel.h"

@interface ASFundTradRecordVC ()

@end

@implementation ASFundTradRecordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void) setupUI {
    
    self.title = ASLocalizedString(@"交易记录");
    self.table.rowHeight = 80;
    self.table.mj_footer.hidden = YES;
    [self.table registerClass:[ASFundTradRecordCell class] forCellReuseIdentifier:@"ASFundTradRecordCell"];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASFundTradRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASFundTradRecordCell"];
    if (self.datas.count) {
        cell.model = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)loadDataAtPage:(NSInteger)page {
    
    [self.datas removeAllObjects];
    
    [self getHistory:@"sender" Complain:^(ASAssertModel *assertModel) {
        
    }];
    
    [self getHistory:@"recipient" Complain:^(ASAssertModel *assertModel) {
            
    }];
}


- (void) getHistory:(NSString *)senderOrecipient Complain:(void(^)(ASAssertModel *assertModel)) complain{
    
    kWeakSelf(weakSelf)
    [LambNetManager GET:JoinParams(getHTTP_get_history, senderOrecipient, lambAddress) parameters:@{} showHud:NO success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray yy_modelArrayWithClass:[ASRecordListModel class] json:responseObject];
            for (ASRecordListModel *model in array) {
                if ([senderOrecipient isEqualToString:@"sender"]) {
                    model.sender = YES;
                }
            }
            if (array.count) {
                [weakSelf.datas addObjectsFromArray:array];
                [weakSelf.table reloadData];
            }
            complain(nil);
            [weakSelf endRefresh];
        }else{
            complain(nil);
            [weakSelf endRefresh];
        }
    } failure:^(NSError * _Nonnull error) {
        complain(nil);
        [weakSelf endRefresh];
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
