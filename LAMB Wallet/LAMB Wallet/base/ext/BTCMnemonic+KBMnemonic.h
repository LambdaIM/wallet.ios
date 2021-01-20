//
//  BTCMnemonic+KBMnemonic.h
//  LAMB Wallet
//
//  Created by Sunny on 2021/1/20.
//  Copyright © 2021 fei. All rights reserved.
//

#import <CoreBitcoin/CoreBitcoin.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTCMnemonic (KBMnemonic)

+ (NSArray*) wordListForType:(BTCMnemonicWordListType)type;

@end

NS_ASSUME_NONNULL_END
