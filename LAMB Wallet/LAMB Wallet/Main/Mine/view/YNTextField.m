

#import "YNTextField.h"

@implementation YNTextField

- (void)deleteBackward {
  
    [super deleteBackward];
    
    if ([self.yn_delegate respondsToSelector:@selector(ynTextFieldDeleteBackward:)]) {
        [self.yn_delegate ynTextFieldDeleteBackward:self];
    }
}


@end
