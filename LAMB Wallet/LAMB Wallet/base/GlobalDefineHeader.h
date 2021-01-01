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
#define DEBUGBASEURL @"http://47.93.196.236:13659"
#define RELEASEBASEURL @"http://39.107.247.86:13659"
//#define RELEASEBASEURL @"39.107.247.86:13659"
#else
#define DEBUGBASEURL @"http://bj1.testnet.lambdastorage.com:13659"
#define RELEASEBASEURL @"http://39.107.247.86:13659"
#endif

#define lambAddress @"lambda1ymms062l3v55tyfkeqp605psvdh4za78k6ufcw"

#endif /* GlobalDefineHeader_h */
