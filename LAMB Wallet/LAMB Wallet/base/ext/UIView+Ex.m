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
    self.clipsToBounds = YES;
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

- (void)addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize borderType:(ASBorderType)type {
    [self addBorderWithColor:color borderSize:borderSize opacity:1.0 margin:0.0 borderType:type];
}

- (void)addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize opacity:(float)opacity margin:(CGFloat)margin borderType:(ASBorderType)type {
    
    if (type & ASBorderTypeTop) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(margin, 0, self.frame.size.width - margin, borderSize);
        [self.layer addSublayer:border];
    }
    
    if (type & ASBorderTypeLeft) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(0, 0, borderSize, self.frame.size.height);
        [self.layer addSublayer:border];
    }
    
    if (type & ASBorderTypeBottom) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(margin, self.frame.size.height - borderSize, self.frame.size.width - margin, borderSize);
        [self.layer addSublayer:border];
    }
    
    if (type & ASBorderTypeRight) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(self.frame.size.width - borderSize, 0, borderSize, self.frame.size.height);
        [self.layer addSublayer:border];
    }
}

- (void)addBorderWithWidth:(CGFloat)width borderColor:(UIColor *)borderColor {
    self.layer.borderWidth = width;
    self.layer.borderColor = borderColor.CGColor;
}


-(void)maddSublayer{
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.1),@(1.0)];
    [gradientLayer setColors:@[(id)[ @"5A95FC".hexColor CGColor],(id)[@"3757E2".hexColor CGColor]]];
    [self.layer addSublayer:gradientLayer];
}

@end
