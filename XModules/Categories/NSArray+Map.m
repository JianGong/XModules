//
//  NSArray+Map.m
//  SXClient
//
//  Created by stcui on 5/6/14.
//
//

#import "NSArray+Map.h"

@implementation NSArray (Map)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id object = block(obj, idx);
        [result addObject:object];
    }];
    return result;
}


- (NSArray *)mapObjectsIgnoreNilUsingBlock:(id (^)(id obj, NSUInteger idx))block;
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id object = block(obj, idx);
        if (object) {
            [result addObject:object];
        }
    }];
    return result;
}

- (NSArray *)uniqMapObjectsIgnoreNilUsingBlock:(id (^)(id obj, NSUInteger idx))block;
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id object = block(obj, idx);
        if (object && ![result containsObject:object]) {
            [result addObject:object];
        }
    }];
    return result;
}

- (NSArray *)flattern
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:4];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [ret addObjectsFromArray:[obj flattern]];
        } else {
            [ret addObject:obj];
        }
    }];
    return ret;
}

- (NSArray *)uniqFlattern
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:4];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [ret addObjectsFromArray:[obj uniqFlattern]];
        } else if (![ret containsObject:obj]) {
            [ret addObject:obj];
        }
    }];
    return ret;
}
@end
