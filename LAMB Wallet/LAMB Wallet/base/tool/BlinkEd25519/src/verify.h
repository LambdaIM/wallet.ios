//
//  verifys.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/4.
//  Copyright © 2020 fei. All rights reserved.
//

#ifndef verify_h
#define verify_h

#include <stdio.h>

int ed25519_verify(const unsigned char *signature, const unsigned char *message, size_t message_len, const unsigned char *public_key) ;

#endif /* verify_h */
