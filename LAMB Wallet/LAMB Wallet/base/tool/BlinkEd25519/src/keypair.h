//
//  keypair.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/11/4.
//  Copyright © 2020 fei. All rights reserved.
//

#ifndef keypair_h
#define keypair_h

#include <stdio.h>

void ed25519_create_keypair(unsigned char *public_key, unsigned char *private_key, const unsigned char *seed) ;

#endif /* keypair_h */
