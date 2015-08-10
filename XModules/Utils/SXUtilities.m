//
//  SXUtilities.m
//  SXClient
//
//  Created by iBcker on 15/4/12.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "SXUtilities.h"

//--------------path--------------
NSString *SXDocumentDirectory(void)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

NSString *SXDocumentDirectoryPath(NSString *fileName)
{
    return [SXDocumentDirectory() stringByAppendingPathComponent:fileName];
}

NSString *SXLibraryDirectory(void)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

NSString *SXLibraryDirectoryPath(NSString *fileName)
{
    return [SXLibraryDirectory() stringByAppendingPathComponent:fileName];
}

NSString *SXCacheDirectory(void)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

NSString *SXCacheDirectoryPath(NSString *fileName)
{
    return [SXCacheDirectory() stringByAppendingPathComponent:fileName];
}

NSString *SXResourcePath(NSString *name,NSString *type)
{
    NSString *file = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return file;
}

NSError *SXRemoveFile(NSString *path)
{
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    return error;
}

//--------------date&time--------------

#define SECONDS_PERMINUTE   60
#define SECONDS_PERHOUR     3600

#define SECONDS_PERDAY      86400 //24*3600

void updateCacheTime(NSString *key)
{
    if (key) {
        key=[NSString stringWithFormat:@"SXUpdateTime_%@",key];
        [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
BOOL isCacheExpire(NSString *key,NSTimeInterval timeOut)
{
    if (!key) {
        return YES;
    }
    key=[NSString stringWithFormat:@"SXUpdateTime_%@",key];
    NSTimeInterval cacheTime=[[NSUserDefaults standardUserDefaults] doubleForKey:key];
    return isCacheTimeExpire(cacheTime,timeOut);
}
BOOL isCacheTimeExpire(NSTimeInterval cacheTime,NSTimeInterval timeOut)
{
    if (fabs([[NSDate date] timeIntervalSince1970]-cacheTime)>timeOut) {
        return YES;
    }else{
        return NO;
    }
}

NSInteger daysSinceToday(NSDate *date,NSTimeZone *timeZone)
{
    NSInteger offset = [timeZone secondsFromGMT];
    NSInteger today = [[NSDate date] timeIntervalSince1970] + offset;
    NSInteger current = [date timeIntervalSince1970] + offset;
    return (current / SECONDS_PERDAY - today / SECONDS_PERDAY);
}

NSInteger hoursSince(NSDate *date)
{
    return [date timeIntervalSinceNow]/SECONDS_PERHOUR;
}

NSInteger minutesSince(NSDate *date)
{
    return [date timeIntervalSinceNow]/SECONDS_PERMINUTE;
}

//--------------tips--------------
id obj2obj(id obj)
{
    id _obj=nil;
    @try {
        NSData *buffer=[NSKeyedArchiver archivedDataWithRootObject:obj];
        _obj = [NSKeyedUnarchiver unarchiveObjectWithData:buffer];
    }
    @catch (NSException *exception) {
        
    }
    return _obj;
}
