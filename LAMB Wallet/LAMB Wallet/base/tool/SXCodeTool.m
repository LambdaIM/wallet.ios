

#import "SXCodeTool.h"
@implementation  UITableView(XS)
- (void)registerXibCell:(Class)xibCellClass {
    NSString *cellClassStr = NSStringFromClass([xibCellClass class]);
    [self registerNib:[UINib nibWithNibName:cellClassStr bundle:nil]
    forCellReuseIdentifier:cellClassStr];
}
@end
@implementation NSNull (XS)
- (id)objectForKeyedSubscript:(id)key {
    return nil;
}

@end
@implementation UIView (XS)
- (void)centerXEqualSuper {
    self.left = (self.superview.width - self.width)*0.5;
}
- (void)centerYEqualSuper {
    self.top = (self.superview.height - self.height)*0.5;
}
@end
@implementation UILabel(XS)
+ (instancetype)texColor:(NSString *)colorStr pfm:(CGFloat)size text:(NSString *)text {
    return [self text:text font:[UIFont pFMediumSize:size] textColorStr:colorStr];
}
+ (instancetype)text:(NSString *)text font:(UIFont *)font textColorStr:(NSString *)textColorStr {
    return [self text:text font:font textColor:textColorStr.hexColor];
}
+ (instancetype)m3b14Text:(NSString *)text {
    return [self texColor:@"3b3b3b" pfm:14 text:text];
}
+ (instancetype)m9514Text:(NSString *)text {
    return [self texColor:@"959595" pfm:14 text:text];
}
+ (instancetype)text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor {

    UILabel *lab = [self new];
    lab.text = text;
    lab.font = font;
    lab.textColor = textColor;
    [lab sizeToFit];
    return lab;
}
@end
@implementation UIFont(XS)
+(instancetype)pFSize:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}
+(instancetype)pFBlodSize:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}
+(instancetype)pFMediumSize:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

@end

@implementation UIButton(XS)
/// [UIButton buttonWithType:UIButtonTypeCustom];
+(instancetype)btn {
    return [self buttonWithType:UIButtonTypeCustom];
}
- (void)setNormalTitle:(NSString *)normalTitle {
    [self setTitle:normalTitle forState:UIControlStateNormal];
}
- (NSString *)normalTitle {
    return [self titleForState:UIControlStateNormal];
}
- (void)setSelectedTitle:(NSString *)selectedTitle {
    [self setTitle:selectedTitle forState:UIControlStateSelected];

}
- (NSString *)selectedTitle {
    return [self titleForState:UIControlStateSelected];
}
- (void)setDisabledTitle:(NSString *)disabledTitle {
    [self setTitle:disabledTitle forState:UIControlStateDisabled];

}
- (NSString *)disabledTitle {
    return [self titleForState:UIControlStateDisabled];

}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}
- (UIColor *)normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}
- (UIColor *)selectedTitleColor {
    return [self titleColorForState:UIControlStateSelected];
}
- (void)setDisabledTitleColor:(UIColor *)disabledTitleColor {
    [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
}
- (UIColor *)disabledTitleColor {
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setNormalImage:(UIImage *)normalImage {
    [self setImage:normalImage forState:UIControlStateNormal];
}
- (UIImage *)normalImage {
    return [self imageForState:UIControlStateNormal];
}
- (void)setSelectedImage:(UIImage *)selectedImage {
    [self setImage:selectedImage forState:UIControlStateSelected];

}
- (UIImage *)selectedImage {
    return [self imageForState:UIControlStateSelected];
}
- (void)setDisabledImage:(UIImage *)disabledImage {
    [self setImage:disabledImage forState:UIControlStateDisabled];
}
- (UIImage *)disabledImage {
    return [self imageForState:UIControlStateDisabled];
}

- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage {
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
}
- (UIImage *)normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage {
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}
- (UIImage *)selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}
- (void)setDisabledBackgroundImage:(UIImage *)disabledBackgroundImage {
    [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}
- (UIImage *)disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}
@end
