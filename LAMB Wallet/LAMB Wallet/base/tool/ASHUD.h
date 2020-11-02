
#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface ASHUD: NSObject

/// toast提示，0.75s后消失
+(void)showHudTipStr:(NSString *)tipStr;
/// toast提示，自定义多少秒后消失
+(void)showHudTipStr:(NSString *)tipStr afterDelay:(NSTimeInterval)delay;
/// 不消失的loading转圈，消失调用hideHUDQuery
+ (MBProgressHUD *)showHUDQuery;
+ (MBProgressHUD *)showHUDQueryisNight:(BOOL)night;
/// 不消失的转圈提提示字，消失调用hideHUDQuery
+ (MBProgressHUD *)showHUDQueryStr:(NSString *)queryStr;
/** 隐藏loading转圈 */
+ (void)hideHUDQuery;

@end
#endif
