//
//  ASNodeModel.h
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/13.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASNodeModel : ASModel<NSCoding>

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, assign) BOOL select;

- (instancetype) initWithBaseUrl:(NSString *) baseUrl port:(NSString *)port nodeName:(NSString *)nodeName select:(BOOL) select;;

@end

NS_ASSUME_NONNULL_END
