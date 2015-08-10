//
//  SWCache.m
//  SinaWeather
//
//  Created by iBcker on 14-6-25.
//
//

#import "SXCache.h"
#import <pthread.h>
#import <UIKit/UIKit.h>

#define wrlock(code)\
pthread_rwlock_wrlock(&rwlock); \
code;\
pthread_rwlock_unlock(&rwlock);

#define rdlock(code)\
pthread_rwlock_rdlock(&rwlock); \
code;\
pthread_rwlock_unlock(&rwlock);


@interface SXCache () {
    NSMutableDictionary *_mcache;
    pthread_rwlock_t rwlock;
    pthread_rwlockattr_t attr;
}
@end

@implementation SXCache
- (id)init
{
    self = [super init];
    if (self) {
        _mcache=[[NSMutableDictionary alloc] init];
        pthread_rwlockattr_init(&attr);
        pthread_rwlock_init(&rwlock, &attr);
        self.autoRelease=YES;
    }
    return self;
}

- (void)setAutoRelease:(BOOL)autoRelease
{
    _autoRelease=autoRelease;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_autoRelease) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemeoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
}

- (void)dealloc
{
    _mcache=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    pthread_rwlock_destroy(&rwlock);
    pthread_rwlockattr_destroy(&attr);
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)key
{
    if (anObject) {
        wrlock([_mcache setObject:anObject forKey:key]);
    }
}

- (id)objectForKey:(id <NSCopying>)key
{
    id obj;
    rdlock(obj = [_mcache objectForKey:key]);
    return obj;
}

- (void)removeObjectForKey:(id <NSCopying>)key
{
    wrlock([_mcache removeObjectForKey:key]);
}

- (void)removeAllObjects
{
    wrlock([_mcache removeAllObjects]);
}

- (NSArray *)allKeys
{
    id obj;
    rdlock(obj = [_mcache allKeys]);
    return obj;
}

- (id)objectForKeyedSubscript:(id <NSCopying>)key
{
    id obj;
    wrlock(
        obj=[_mcache objectForKey:key];
    );
    return obj;
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    wrlock([_mcache setObject:obj forKey:key]);
}

- (void)didReceiveMemeoryWarning:(NSNotification *)notification
{
    wrlock(
        NSArray *keys = [_mcache allKeys];
        for (id key in keys) {
            NSObject *obj=[_mcache objectForKey:key];
            if (1==CFGetRetainCount((__bridge CFTypeRef)obj)) {
                [_mcache removeObjectForKey:key];
            }
        }
    );
}

@end
