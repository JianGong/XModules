//
//  SXViewModel.m
//  SXClient
//
//  Created by iBcker on 14-10-6.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXViewModel.h"
#import "NSObject+Utils.h"
#import "EGOCache+helper.h"

@implementation SXViewModel

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)hasMore
{
    if ([self.objs count]==0) {
        return NO;
    }
    return YES;
}

- (void)loadCache:(void(^)(id res))complete
{
    if (complete) {
        complete(nil);
    }
}

- (void)loadData:(void(^)(id res,NSError *error))complete
{
    if (complete) {
        complete(nil,nil);
    }
}

- (EGOCache *)fileCache
{
    if (!_fileCache) {
        _fileCache=[EGOCache globalCache];
    }
    return _fileCache;
}

- (void)loadMore:(void(^)(id res,NSError *error))complete
{
    if (complete) {
        complete(nil,nil);
    }
}

- (void)loadPage:(NSInteger)page complete:(void(^)(id res,NSError *error))complete
{
    if (complete) {
        complete(nil,nil);
    }
}

- (NSError *)parseError:(NSDictionary *)userInfo
{
    return [NSError errorWithDomain:@"parse data error" code:-1 userInfo:userInfo];
}

- (void)synCacheToDisk
{
    NSString *key = [self keyForDiskCache];
    if (key) {
        NSInteger size = [self sizeForDiskCache];
        if (size>0) {
            NSArray *data = [self.objs count]>size?[self.objs subarrayWithRange:NSMakeRange(0, size)]:[self.objs copy];
            self.fileCache[key]=data;
        }else if (size==0){
            [self.fileCache removeCacheForKey:key];
        }
    }
}

- (NSInteger)sizeForDiskCache
{
    return 0;
}

- (NSString *)keyForDiskCache
{
    return self.className;
}

- (void)cancelCurrentLoad
{
}

@end
