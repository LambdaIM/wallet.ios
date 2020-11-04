//
//  signs.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/4.
//  Copyright © 2020 fei. All rights reserved.
//

#ifndef sign_h
#define sign_h

#include <stdio.h>

void ed25519_sign(unsigned char *signature, const unsigned char *message, size_t message_len, const unsigned char *public_key, const unsigned char *private_key) ;

#endif /* sign_h */
