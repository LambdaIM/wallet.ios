
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITableView(XS)
/// 注册xib cell
- (void)registerXibCell:(Class)xibCellClass;

@end
@interface UIView(XS)
+ (instancetype)creatLineView;
- (void)centerXEqualSuper;
- (void)centerYEqualSuper;
@end
@interface UILabel(XS)
+ (instancetype)ms3b14Text:(NSString *)text;
+ (instancetype)ms9514Text:(NSString *)text;
/// PingFang-SC-Medium  3b3b3b 14
+ (instancetype)m3b14Text:(NSString *)text;
+ (instancetype)m9514Text:(NSString *)text;

/// PingFang-SC-Medium 
+ (instancetype)texColor:(NSString *)colorStr pfm:(CGFloat)size text:(NSString *)text;
+ (instancetype)text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;
+ (instancetype)text:(NSString *)text font:(UIFont *)font textColorStr:(NSString *)textColorStr;
+ (instancetype)creatNewLabel:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColorStr:(NSString *)textColorStr;
@end
@interface UIFont(XS)
+(instancetype)pFSize:(CGFloat)size;
+(instancetype)pFBlodSize:(CGFloat)size;
+(instancetype)pFMediumSize:(CGFloat)size;
@end
@interface UIButton(XS)
+ (instancetype)btn;


+ (instancetype)creatButton:(CGRect)frame title:(NSString *)tilte titleColor:(UIColor *) titleColor titleFont:(CGFloat) titleFont target:(id)target action:(SEL)action tag:(NSInteger)tag;

/// 获取或设置 UIControlStateNormal 状态下的标题
@property (nullable, nonatomic) NSString *normalTitle;
/// 获取或设置 UIControlStateSelected 状态下的标题
@property (nullable, nonatomic) NSString *selectedTitle;
/// 获取或设置 UIControlStateDisabled 状态下的标题
@property (nullable, nonatomic) NSString *disabledTitle;

/// 获取或设置 UIControlStateNormal 状态下的标题的颜色
@property (nullable, nonatomic) UIColor *normalTitleColor;
/// 获取或设置 UIControlStateSelected 状态下的标题的颜色
@property (nullable, nonatomic) UIColor *selectedTitleColor;
/// 获取或设置 UIControlStateDisabled 状态下的标题的颜色
@property (nullable, nonatomic) UIColor *disabledTitleColor;

/// 获取或设置 UIControlStateNormal 状态下的图片
@property (nullable, nonatomic) UIImage *normalImage;
/// 获取或设置 UIControlStateSelected 状态下的图片
@property (nullable, nonatomic) UIImage *selectedImage;
/// 获取或设置 UIControlStateDisabled 状态下的图片
@property (nullable, nonatomic) UIImage *disabledImage;

/// 获取或设置 UIControlStateNormal 状态下的背景图片
@property (nullable, nonatomic) UIImage *normalBackgroundImage;
/// 获取或设置 UIControlStateSelected 状态下的背景图片
@property (nullable, nonatomic) UIImage *selectedBackgroundImage;
/// 获取或设置 UIControlStateDisabled 状态下的背景图片
@property (nullable, nonatomic) UIImage *disabledBackgroundImage;
@end
NS_ASSUME_NONNULL_END
