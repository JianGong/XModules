//
//  EGOCache+helper.h
//  SXClient
//
//  Created by iBcker on 14-10-10.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "EGOCache.h"

@interface EGOCache (helper)
- (void)setForeverObject:(id<NSCoding>)anObject forKey:(NSString*)key;

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
@end
