//
//  KBImportPocketVC.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "KBImportPocketVC.h"
#import <CMPageTitleView/CMPageTitleView.h>
#import "KBMnemonicImportVC.h"
#import "KBFileImportVC.h"

@interface KBImportPocketVC ()

@end

@implementation KBImportPocketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
       [self.view addSubview:pageView];
       
       [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.mas_equalTo(0);
           make.top.mas_equalTo(15);
           make.height.mas_equalTo(kScreenH -  kll_Status_NavBarHeight);
           
       }];
       pageView.delegate = self;
       
       CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
//       config.cm_childControllers = self.childControllers;//必传参数
       
       pageView.cm_config = config;
    
}

 
@end
