//
//  NSArray+Map.h
//  SXClient
//
//  Created by stcui on 5/6/14.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (Map)
- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;
- (NSArray *)mapObjectsIgnoreNilUsingBlock:(id (^)(id obj, NSUInteger idx))block;
- (NSArray *)uniqMapObjectsIgnoreNilUsingBlock:(id (^)(id obj, NSUInteger idx))block;
- (NSArray *)flattern;
- (NSArray *)uniqFlattern;
@end
