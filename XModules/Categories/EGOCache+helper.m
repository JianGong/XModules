//
//  EGOCache+helper.m
//  SXClient
//
//  Created by iBcker on 14-10-10.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "EGOCache+helper.h"

@implementation EGOCache (helper)

- (void)setForeverObject:(id<NSCoding>)anObject forKey:(NSString*)key;
{
    [self setObject:anObject forKey:key withTimeoutInterval:(~0ull)];
}

- (id)objectForKeyedSubscript:(NSString *)key
{
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key
{
    if (key) {
        [self setObject:obj forKey:key];
    }
}
@end
