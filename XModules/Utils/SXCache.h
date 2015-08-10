//
//  SWCache.h
//  SinaWeather
//
//  Created by iBcker on 14-6-25.
//
//

#import <Foundation/Foundation.h>

@interface SXCache : NSObject

@property (nonatomic,assign)BOOL autoRelease; //内存警告时自动回收，默认是yes

- (void)setObject:(id)anObject forKey:(id <NSCopying>)key;
- (id)objectForKey:(id <NSCopying>)key;
- (void)removeObjectForKey:(id <NSCopying>)key;
- (void)removeAllObjects;

- (NSArray *)allKeys;

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@end
