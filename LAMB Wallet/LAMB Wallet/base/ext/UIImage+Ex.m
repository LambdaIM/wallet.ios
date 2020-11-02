//
//  UIImage+Ex.m
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import "UIImage+Ex.h"

@implementation UIImage (Ex)

/// 根据view尺寸生成渐变的通用蓝色图片
+ (UIImage *)gradientImgWithView:(UIView *)view {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = view.bounds;
    gl.startPoint = CGPointMake(1, 0.5);
    gl.endPoint = CGPointMake(0, 0.5);
    gl.colors = @[(__bridge id)@"#5A95FC".hexColor.CGColor, (__bridge id)@"#3757E2".hexColor.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    
    UIGraphicsBeginImageContextWithOptions(gl.frame.size, NO, [UIScreen mainScreen].scale);

    [gl renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}
@end
