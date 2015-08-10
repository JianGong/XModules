//
//  SXUtilities.h
//  SXClient
//
//  Created by iBcker on 15/4/12.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import <Foundation/Foundation.h>

//--------------path--------------
NSString *SXDocumentDirectory(void);
NSString *SXDocumentDirectoryPath(NSString *fileName);

NSString *SXLibraryDirectory(void);
NSString *SXLibraryDirectoryPath(NSString *fileName);

NSString *SXCacheDirectory(void);
NSString *SXCacheDirectoryPath(NSString *fileName);

NSString *SXResourcePath(NSString *name,NSString *type);

NSError *SXRemoveFile(NSString *path);

//--------------date&time--------------

#ifndef DataRefreshTime
    #define DataRefreshTime 300 //s
#endif

#define SXCacheIsExpire(key) isCacheExpire(key,DataRefreshTime)

void updateCacheTime(NSString *key);
BOOL isCacheExpire(NSString *key,NSTimeInterval timeOut);
BOOL isCacheTimeExpire(NSTimeInterval cacheTime,NSTimeInterval timeOut);

NSInteger daysSinceToday(NSDate *date,NSTimeZone *timeZone);
NSInteger hoursSince(NSDate *date);
NSInteger minutesSince(NSDate *date);

//--------------tips--------------
NS_INLINE BOOL isNSArray(id obj){return [obj isKindOfClass:[NSArray class]];}
NS_INLINE BOOL isNSDictionary(id obj){return [obj isKindOfClass:[NSDictionary class]];}
NS_INLINE BOOL isNSString(id obj){return [obj isKindOfClass:[NSString class]];}
NS_INLINE BOOL isEffectiveNSString(id obj){return [obj isKindOfClass:[NSString class]]&&[((NSString *)obj) length]>0;}

NS_INLINE BOOL isSXEntity(id obj){return [obj isKindOfClass:[NSDictionary class]]&&obj[@"id"];}
///try to deep copy obj to obj use NSKeyedArchiver
id obj2obj(id obj);