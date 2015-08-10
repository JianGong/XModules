//
//  SWScopeMath.m
//  SXClient
//
//  Created by iBcker on 14-4-23.
//
//

#import "SWScopeMatch.h"

NSString *const kScopMinV = @"min";
NSString *const kScopMaxV = @"max";
NSString *const kScopResult = @"result";

NSDictionary *SWScopeMake(id min,id max,id Obj)
{
    return @{kScopMinV:min,kScopMaxV:max,kScopResult:Obj};
}

@interface SWScopeMatch()
@property (nonatomic,strong)NSMutableArray *scops;

@end

@implementation SWScopeMatch

- (id)init
{
    return [self initWithCapacity:5];
}

- (id)initWithCapacity:(NSInteger)capacity
{
    self = [super init];
    if (self) {
        self.scops = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return  self;
}

- (void)addScop:(NSArray *)scop
{
    [self.scops addObject:scop];
}

- (void)addScops:(NSArray *)scops
{
    [self.scops addObjectsFromArray:scops];
}

- (void)cleanScops
{
    [self.scops removeAllObjects];
}

-(id)matchf:(CGFloat)vaule
{
    for (NSDictionary *scop in _scops) {
        if ([scop[kScopMinV] floatValue]<vaule&&vaule<[scop[kScopMaxV] floatValue]) {
            return scop[kScopResult];
        }
    }
    return nil;
}

- (id)matchi:(NSInteger)vaule
{
    for (NSDictionary *scop in _scops) {
        if ([scop[kScopMinV] integerValue]<vaule&&vaule<[scop[kScopMaxV] integerValue]) {
            return scop[kScopResult];
        }
    }
    return nil;
}

- (id)matchfEq:(CGFloat)vaule
{
    for (NSDictionary *scop in _scops) {
        if ([scop[kScopMinV] floatValue]<=vaule&&vaule<=[scop[kScopMaxV] floatValue]) {
            return scop[kScopResult];
        }
    }
    return nil;
}


- (id)matchiEq:(NSInteger)vaule
{
    for (NSDictionary *scop in _scops) {
        if ([scop[kScopMinV] integerValue]<=vaule&&vaule<=[scop[kScopMaxV] integerValue]) {
            return scop[kScopResult];
        }
    }
    return nil;
}

@end
