//
//  Ed25519Keypair.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/29.
//  Copyright © 2020 fei. All rights reserved.
//

#import "Ed25519Keypair.h"
#include "seed.h"
#include "keypair.h"
#include "sign.h"
#include "verify.h"
@implementation Ed25519Keypair


+(Ed25519Keypair*)generateEd25519KeyPair

{
    unsigned char seed[32],publickey[32],privatekey[64];
    ed25519_create_seed(seed);
    ed25519_create_keypair(publickey, privatekey, seed);
    Ed25519Keypair *keypair = [[Ed25519Keypair alloc] init];

    keypair.publickey= [NSData dataWithBytes:publickey length:32];

    keypair.privatekey= [NSData dataWithBytes:privatekey length:64];

    return keypair;
}

+(NSData*)BLinkEd25519_Signature:(Ed25519Keypair*)ed25519keypair Content:(NSString*)content

{

    unsigned char signature[64];

    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];

    ed25519_sign(signature, [contentData bytes], contentData.length, [ed25519keypair.publickey bytes], [ed25519keypair.privatekey bytes]);

    return[NSData dataWithBytes:signature length:64];

}

+(BOOL)BlinkEd25519_Verify:(NSData*)signatureData content:(NSData*)contentData Ed25519Keypair:(Ed25519Keypair*)ed25519keypair

{
    return ed25519_verify([signatureData bytes], [contentData bytes], contentData.length, [ed25519keypair.privatekey bytes]);
}
 
@end
