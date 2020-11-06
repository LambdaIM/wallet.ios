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
    gl.colors = @[(__bridge id)@"#3757E2".hexColor.CGColor,(__bridge id)@"#5A95FC".hexColor.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    
    UIGraphicsBeginImageContextWithOptions(gl.frame.size, NO, [UIScreen mainScreen].scale);

    [gl renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

/**

 生成二维码(中间有小图片)

 QRStering：所需字符串

 centerImage：二维码中间的image对象

 */

+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage{

    // 创建滤镜对象

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    // 恢复滤镜的默认属性

    [filter setDefaults];

    // 将字符串转换成 NSdata

    NSData *dataString = [QRString dataUsingEncoding:NSUTF8StringEncoding];

    // 设置过滤器的输入值, KVC赋值

    [filter setValue:dataString forKey:@"inputMessage"];

    // 获得滤镜输出的图像

    CIImage *outImage = [filter outputImage];

    // 图片小于(27,27),我们需要放大

    outImage = [outImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];

    // 将CIImage类型转成UIImage类型

    UIImage *startImage = [UIImage imageWithCIImage:outImage];

    // 开启绘图, 获取图形上下文

    UIGraphicsBeginImageContext(startImage.size);

    

    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点

    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];

    // 再把小图片画上去

    CGFloat icon_imageW = 50;

    CGFloat icon_imageH = icon_imageW;

    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;

    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;

    [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];

    // 获取当前画得的这张图片

    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();

    // 关闭图形上下文

    UIGraphicsEndImageContext();

    //返回二维码图像

    return qrImage;

}

/** 将CIImage转换成UIImage 并放大(内部转换使用)*/

+ (UIImage *)imageWithImageSize:(CGFloat)size withCIIImage:(CIImage *)ciiImage{

    CGRect extent = CGRectIntegral(ciiImage.extent);

    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

    // 1.创建bitmap;

    size_t width = CGRectGetWidth(extent) * scale;

    size_t height = CGRectGetHeight(extent) * scale;

    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();

    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);

    CIContext *context = [CIContext contextWithOptions:nil];

    CGImageRef bitmapImage = [context createCGImage:ciiImage fromRect:extent];

    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);

    CGContextScaleCTM(bitmapRef, scale, scale);

    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片

    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);

    CGContextRelease(bitmapRef);

    CGImageRelease(bitmapImage);

    return [UIImage imageWithCGImage:scaledImage];

}

@end
