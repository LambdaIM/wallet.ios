
#import <Foundation/Foundation.h>

@interface ASLocalizedManager : NSObject

+ (instancetype)shareManager;

- (NSBundle *)bundle;

- (NSString *)currentLanguage;

- (NSString *)currentLanguageDes;

- (NSString *)stringWithKey:(NSString *)key;

- (void)setUserLanguage:(NSString *)language;

@end

static inline NSString *ASLocalizedString(NSString *key) {
    NSString *value = [[ASLocalizedManager shareManager] stringWithKey:key];
    if (value.length > 0) {
        return value;
    }
    return key;
}
/*
 设置国际化
 self.m_lab.text = ASLocalizedString(@"注册");

 
 回示语种
 [[ASLocalizedManager shareManager] currentLanguageDes];
 
 设置语种
 if ([[[ASLocalizedManager shareManager] currentLanguageDes] isEqualToString:@"简体中文"]) {
 
     [[ASLocalizedManager shareManager] setUserLanguage:@"en"];
 } else {
     [[ASLocalizedManager shareManager] setUserLanguage:@"zh-Hans"];
 }
 
 AppDelegate监听切换语种通知，刷新rootVC
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpTabBar) name:kUSER_CHANGE_LANGUAGE object:nil];
- (void)setUpTabBar {
 // 新xCode创建的项目得这样设置
 [UIApplication sharedApplication].windows.firstObject.rootViewController =  [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;;
}
 
 */
