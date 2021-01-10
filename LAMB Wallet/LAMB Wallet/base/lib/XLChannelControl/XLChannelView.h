//
//  XLChannelView.h
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLChannelView : UIView

@property (nonatomic, strong) NSMutableArray *enabledTitles;
@property (nonatomic, strong) NSMutableArray *disabledTitles;
@property (nonatomic, assign) BOOL enableSelect;

- (void)reloadData;
- (instancetype)initWithFrame:(CGRect)frame enableSelect:(BOOL) enableSelect;

@end
