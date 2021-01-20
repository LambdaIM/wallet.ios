
#import "ASLocalizedManager.h"

@implementation ASLocalizedManager

static NSBundle *_bundle;
static NSString *const kUserLanguage = @"kUserLanguage";

+ (instancetype)shareManager {
    static ASLocalizedManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASLocalizedManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        if (!_bundle) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userLanguage = [defaults valueForKey:kUserLanguage];
            //用户未手动设置过语言
            if (userLanguage.length == 0) {
                NSString *localeLanguageCode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
                userLanguage = localeLanguageCode;
            }
            
            if ([userLanguage hasPrefix:@"zh-"]) {
                userLanguage = @"zh-Hans";
            } else{
                userLanguage = @"en";
            }
            [defaults setValue:userLanguage forKey:kUserLanguage];
            NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
            _bundle = [NSBundle bundleWithPath:path];
        }
    }
    return self;
}

- (NSBundle *)bundle {
    return _bundle;
}

- (NSString *)currentLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [defaults valueForKey:kUserLanguage];
    if (userLanguage.length == 0) {
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = languages.firstObject;
        return systemLanguage;
    }
    return userLanguage;
}

- (NSString *)currentLanguageDes {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [defaults valueForKey:kUserLanguage];
    if (userLanguage.length == 0) {
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = languages.firstObject;
        userLanguage = systemLanguage;
    }
    if ([userLanguage isEqualToString:@"zh-Hans"]) {
        return @"简体中文";
    }else if ([userLanguage isEqualToString:@"en"]){
        return @"英语";
    } else {
        return @"";
    }
}

- (void)setUserLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
    [defaults setValue:language forKey:kUserLanguage];
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUSER_CHANGE_LANGUAGE object:nil];
}

- (NSString *)stringWithKey:(NSString *)key {
    if (_bundle) {
        return [_bundle localizedStringForKey:key value:nil table:@"Localizable"];
    }else {
        return NSLocalizedString(key, nil);
    }
}
@end
