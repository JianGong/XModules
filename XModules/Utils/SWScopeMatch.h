//
//  SWScopeMath.h
//  SXClient
//
//  Created by iBcker on 14-4-23.
//
//  区间结果匹配器
//  例如指定 x>3&&x<5 return @"4.png"
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

extern NSString *const kScopMinV;
extern NSString *const kScopMaxV;
extern NSString *const kScopResult;

extern NSDictionary* SWScopeMake(id min,id max,id Obj);

@interface SWScopeMatch : NSObject
- (id)initWithCapacity:(NSInteger)capacity;

- (void)addScop:(NSDictionary *)scop;
- (void)addScops:(NSArray *)scops;
- (void)cleanScops;

- (id)matchf:(CGFloat)vaule;
- (id)matchi:(NSInteger)vaule;

//带等于判断
- (id)matchfEq:(CGFloat)vaule;
- (id)matchiEq:(NSInteger)vaule;

@end
