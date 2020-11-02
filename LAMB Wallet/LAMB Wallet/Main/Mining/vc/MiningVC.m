//
//  MiningVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "MiningVC.h"
#import "MiningCell.h"
#import "SXCodeTool.h"
#import "MiningHeaderView.h"
#import "UIView+Ex.h"
#import "KBVerifyNodeDetailVC.h"

@interface MiningVC ()
@property(nonatomic, weak) MiningHeaderView *header;
@end

@implementation MiningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUIRealTime];
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.rowHeight = 70;
    [self.table registerXibCell:[MiningCell class]];
    
    MiningHeaderView *header =
    [[MiningHeaderView alloc] initWithFrame:CGRectMake(15, 0, kScreenW-2*15, 260)];
    self.table.tableHeaderView = header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MiningCell *cell = [MiningCell cellFromTable:tableView];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(MiningCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self tableView:tableView numberOfRowsInSection:0]-1){
        [cell.m_contentView addCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) radius:8];
    } else {
        
        cell.m_contentView.layer.mask = nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self push:[KBVerifyNodeDetailVC new]];
}
@end
