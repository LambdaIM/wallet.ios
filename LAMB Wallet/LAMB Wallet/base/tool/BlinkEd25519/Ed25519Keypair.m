//
//  Ed25519Keypair.m
//  LAMB Wallet
//
//  Created by fei on 2020/10/29.
//  Copyright © 2020 fei. All rights reserved.
//

#import "Ed25519Keypair.h" 


@implementation Ed25519Keypair

 

+(Ed25519Keypair*)generateEd25519KeyPair

{

   unsignedcharseed[32],publickey[32],privatekey[64];
   ed25519_create_seed(seed);
   ed25519_create_keypair(publickey, privatekey, seed);
    Ed25519Keypair *keypair = [[Ed25519Keypair alloc] init];

    keypair.publickey= [NSDatadataWithBytes:publickeylength:32];

    keypair.privatekey= [NSDatadataWithBytes:privatekeylength:64];



    returnkeypair;

}

+(NSData*)BLinkEd25519_Signature:(Ed25519Keypair*)ed25519keypair Content:(NSString*)content

{

    unsignedcharsignature[64];



    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];

    ed25519_sign(signature, [contentDatabytes], contentData.length, [ed25519keypair.publickeybytes], [ed25519keypair.privatekeybytes]);



    return[NSDatadataWithBytes:signaturelength:64];

}

+(BOOL)BlinkEd25519_Verify:(NSData*)signatureData content:(NSData*)contentData Ed25519Keypair:(Ed25519Keypair*)ed25519keypair

{

    returned25519_verify([signatureDatabytes], [contentDatabytes], contentData.length, [ed25519keypair.privatekeybytes]);

}
 
@end
