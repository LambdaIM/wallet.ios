//
//  ASLanguageVC.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/26.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASLanguageVC.h"

@interface ASLanguageVC ()
@end

@implementation ASLanguageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.rowHeight = 55;
    self.title = ASLocalizedString(@"语言");

    
    self.datas = @[@{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"title":ASLocalizedString(@"中文"), @"sel":@"SwitchToChinese"},
                   @{@"UITableViewCellStyle":@0, @"UITableViewCellAccessoryType": @1, @"title":@"English", @"sel":@"SwitchToEnglish"}];
    [self.table reloadData];
}
- (void)SwitchToChinese {
    [[ASLocalizedManager shareManager] setUserLanguage:@"zh-Hans"];
}
- (void)SwitchToEnglish {
    [[ASLocalizedManager shareManager] setUserLanguage:@"en"];

}
@end
