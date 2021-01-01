//
//  UIImage+Ex.h
//  LAMB Wallet
//
//  Created by dfpo on 2020/10/28.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Ex)
+ (UIImage *)gradientImgWithView:(UIView *)view;
/**

 生成二维码(中间有小图片)

 QRStering：字符串

 centerImage：二维码中间的image对象

 */

+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage;

/**
 *  @brief 保存相册
 *
 *  @param completeBlock 成功回调
 *  @param failBlock 出错回调
 */
- (void)savedPhotosAlbumWithCompleteBlock:(void (^)(void))completeBlock failBlock:(void (^)(NSError *))failBlock;

@end

NS_ASSUME_NONNULL_END
