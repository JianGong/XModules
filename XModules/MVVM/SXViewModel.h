//
//  SXViewModel.h
//  SXClient
//
//  Created by iBcker on 14-10-6.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGOCache.h"

@interface SXViewModel : NSObject
@property (nonatomic,strong)NSArray *objs;
@property (nonatomic,strong)EGOCache *fileCache;
@property (assign,readonly)BOOL isLoading;
@property (assign,readonly)BOOL isRefreshing;
@property (assign,readonly)BOOL isLoadMore;
@property (assign,readonly)BOOL hasMore;

@property (strong,readonly)NSString *keyForDiskCache;
@property (assign,readonly)NSInteger sizeForDiskCache;

- (void)loadCache:(void(^)(id res))complete;

- (void)loadData:(void(^)(id res,NSError *error))complete;

- (void)loadMore:(void(^)(id res,NSError *error))complete;

- (void)loadPage:(NSInteger)page complete:(void(^)(id res,NSError *error))complete;

- (void)synCacheToDisk;

- (NSError *)parseError:(NSDictionary *)userInfo;

- (void)cancelCurrentLoad;
@end
