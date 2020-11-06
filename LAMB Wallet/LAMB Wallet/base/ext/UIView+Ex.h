//
//  UIView+Ex.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, ASBorderType) {
    ASBorderTypeTop     = 1 << 0,
    ASBorderTypeLeft    = 1 << 1,
    ASBorderTypeBottom  = 1 << 2,
    ASBorderTypeRight   = 1 << 3,
    ASBorderTypeAll     = ASBorderTypeTop | ASBorderTypeLeft | ASBorderTypeBottom | ASBorderTypeRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Ex)
- (void)addCorner;
- (void)addCorner:(CGFloat)corner;
- (void)addCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 *  @brief 添加边框
 *
 *  @param color      边框颜色
 *  @param borderSize 边框宽度
 *  @param type       边框类型
 */
- (void)addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize borderType:(ASBorderType)type;

- (void)addBorderWithWidth:(CGFloat)width borderColor:(UIColor *)borderColor ;

@end

NS_ASSUME_NONNULL_END
