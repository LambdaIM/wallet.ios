//
//  ASScanViewController.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/5.
//  Copyright © 2020 fei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ASScanTypeQrCode,
    ASScanTypeBarCode,
    ASScanTypeAll,
} ASScanType;

@interface ASScanView : UIView

-(id)initWithFrame:(CGRect)frame style:(NSString *)style;

- (void)stopAnimating;

@property (nonatomic, assign) ASScanType scanType;

@end
