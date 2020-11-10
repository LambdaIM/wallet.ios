//
//  KBBipManager.h
//  LAMB Wallet
//
//  Created by fei on 2020/11/10.
//  Copyright © 2020 fei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KBBipManager : NSObject

 
+ (KBBipManager *)manager;

- (NSString *)generateMnemonicString:(NSNumber *)strlength language:(NSString *)language;
 
@end

NS_ASSUME_NONNULL_END
