
#import <UIKit/UIKit.h>

@class YNTextField;



@protocol YNTextFieldDelegate <NSObject>

- (void)ynTextFieldDeleteBackward:(YNTextField *)textField;

@end



@interface YNTextField : UITextField

@property (nonatomic, assign) id <YNTextFieldDelegate> yn_delegate;


@end
