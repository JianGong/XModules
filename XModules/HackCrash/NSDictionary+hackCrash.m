//
//  NS+hackCrash.m
//  SXClient
//
//  Created by iBcker on 14-8-5.
//
//

#import "NSDictionary+hackCrash.h"

@implementation NSDictionary (hackCrash)
- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    NSAssert(NO, @"NSDictionary why call index method?");
    return nil;
}
- (id)objectAtIndex:(NSUInteger)index
{
    NSAssert(NO, @"NSDictionary why call objectAtIndex?");
    return nil;
}
- (id)firstObject
{
    NSAssert(NO, @"NSDictionary why call firstObject?");
    return nil;
}
- (id)lastObject
{
    NSAssert(NO, @"NSDictionary why call lastObject?");
    return nil;
}
- (NSUInteger)indexOfObject:(id)anObject
{
    NSAssert(NO, @"NSDictionary why call indexOfObject:?");
    return NSNotFound;
}
- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes
{
    NSAssert(NO, @"NSDictionary why call objectsAtIndexes:?");
    return nil;
}
- (NSArray *)subarrayWithRange:(NSRange)range
{
    NSAssert(NO, @"NSDictionary why call subarrayWithRange:?");
    return nil;
}
@end
