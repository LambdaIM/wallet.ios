#import "ASHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ASLocalizedManager.h"
static const NSInteger kHUDQueryViewTag = 90101;

@implementation ASHUD
+(void)showHudTipStr:(NSString *)tipStr{
    [self showHudTipStr:tipStr afterDelay:0.75];
}
+(void)showHudTipStr:(NSString *)tipStr afterDelay:(NSTimeInterval)delay {
    
    [self hideHUDQuery];
    BOOL hasStr = tipStr && tipStr.length > 0;
    if (!hasStr) {
        
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font= [UIFont systemFontOfSize: 16];
    hud.detailsLabel.text = ASLocalizedString(tipStr);
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    // 圆角
    hud.bezelView.layer.cornerRadius = 8;
    BOOL isNight = NO;
    
    hud.bezelView.color = @"#4B515C".hexColor;
    
    if (isNight) {
        // 蒙板颜色
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    } else {
        // 蒙板颜色
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    
    
    
    [hud hideAnimated:YES afterDelay: delay];
}
+ (MBProgressHUD *)showHUDQuery {
    return [self showHUDQueryStr:nil];
}
+ (MBProgressHUD *)showHUDQueryStr:(NSString *)queryStr {
    BOOL isNight = NO;
    return [self showHUDQueryStr:queryStr isNight:isNight];
}

+ (MBProgressHUD *)showHUDQueryisNight:(BOOL)night {
    return [self showHUDQueryStr:nil isNight:night];
}
+ (MBProgressHUD *)showHUDQueryStr:(NSString *)queryStr isNight:(BOOL)night{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    if (queryStr.length > 0) {
        hud.label.text =  ASLocalizedString(queryStr);
        hud.label.font = [UIFont systemFontOfSize: 16];
        hud.margin = 10.f;
        hud.label.textColor = [UIColor whiteColor];
    }
    
    BOOL isNight = NO;
    hud.bezelView.color = @"#4B515C".hexColor;
    
    if (night || isNight) {
        // 蒙板颜色
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    } else {
        // 蒙板颜色
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    return hud;
}
+ (void)hideHUDQuery{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            
            if (obj.tag == kHUDQueryViewTag) {
                
                [obj removeFromSuperview];
            }
        }];
    });
}

@end
