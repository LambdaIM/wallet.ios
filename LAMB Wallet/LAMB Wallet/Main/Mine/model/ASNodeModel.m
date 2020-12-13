//
//  ASNodeModel.m
//  LAMB Wallet
//
//  Created by Sunny on 2020/12/13.
//  Copyright © 2020 fei. All rights reserved.
//

#import "ASNodeModel.h"

@implementation ASNodeModel

- (instancetype)initWithBaseUrl:(NSString *)baseUrl port:(NSString *)port nodeName:(NSString *)nodeName select:(BOOL)select{
    if (self = [super init]) {
        _baseUrl = baseUrl;
        _port = port;
        _nodeName = nodeName;
        _select = select;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_baseUrl forKey:@"baseUrl"];
    [aCoder encodeObject:_port forKey:@"port"];
    [aCoder encodeObject:_nodeName forKey:@"nodeName"];
    [aCoder encodeBool:_select forKey:@"select"];

}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _baseUrl = [aDecoder decodeObjectForKey:@"baseUrl"];
        _port = [aDecoder decodeObjectForKey:@"port"];
        _nodeName = [aDecoder decodeObjectForKey:@"nodeName"];
        _select = [aDecoder decodeBoolForKey:@"select"];
    }
    return self;
}

@end
