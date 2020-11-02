//
//  UIView+Ex.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/27.
//  Copyright © 2020 fei. All rights reserved.
//

#import "UIView+Ex.h"

@implementation UIView (Ex)

/// 简单添加半高圆角，用的 cornerRadius masksToBounds
- (void)addCorner {
    [self addCorner:self.height * 0.5];
}
/// 简单添加圆角，用的 cornerRadius masksToBounds
-(void)addCorner:(CGFloat)corner {
    self.layer.cornerRadius = corner;
    self.layer.masksToBounds = YES;
}
/// 添加上圆角或下圆角(CAShapeLayer)，全圆角建议用 addCorner:
- (void)addCorners:(UIRectCorner)corners radius:(CGFloat)radius{
    if (self.constraints.count > 0) {
        [self.superview setNeedsLayout];
        [self.superview layoutIfNeeded];
    }
    
    CGRect b = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:b byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = b;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}
@end
