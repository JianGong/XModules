//
//  NSArray+hackCrash.m
//  SXClient
//
//  Created by iBcker on 14-8-5.
//
//

#import "NSArray+hackCrash.h"

@implementation NSArray (hackCrash)
- (id)objectForKeyedSubscript:(id)key
{
    NSAssert(NO, @"NSArray why call index method?");
    return nil;
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    NSAssert(NO, @"NSArray why call index method?");
}

- (id)objectForKey:(id)key
{
    NSAssert(NO, @"NSArray why call objectForKey?");
    return nil;
}
- (void)removeObjectForKey:(id)aKey
{
    NSAssert(NO, @"NSArray why call removeObjectForKey:?");
}
- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    NSAssert(NO, @"NSArray why call setObject:forKey?");
}
- (id)allKeys
{
    NSAssert(NO, @"NSArray why call allKeys?");
    return nil;
}
- (id)allValues
{
    NSAssert(NO, @"NSArray why call allValues?");
    return nil;
}
@end
