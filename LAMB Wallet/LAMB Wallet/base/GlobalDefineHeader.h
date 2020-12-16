//
//  GlobalDefineHeader.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/12.
//  Copyright © 2020 fei. All rights reserved.
//
#ifndef GlobalDefineHeader_h
#define GlobalDefineHeader_h



#ifdef DEBUG
#define DEBUGBASEURL @"http://39.107.247.86:13659"
#define RELEASEBASEURL @"http://bj1.testnet.lambdastorage.com:13659"
//#define RELEASEBASEURL @"39.107.247.86:13659"
#else
#define DEBUGBASEURL @"http://bj1.testnet.lambdastorage.com:13659"
#define RELEASEBASEURL @"http://39.107.247.86:13659"
#endif

#define lambAddress @"lambda1s6lujxu6evv969t86hpkcr0t6j6fxe0pz33e5s"

#endif /* GlobalDefineHeader_h */
