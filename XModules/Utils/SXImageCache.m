//
//  SWImageCache.m
//  SinaWeather
//
//  Created by iBcker on 14-6-25.
//
//

#import "SXImageCache.h"
#import "SXCache.h"
#import "UIImage+factory.h"
#import "UIColor+HexString.h"

@implementation SXImageCache
{
    SXCache *_memoryCache;
}

-(id)init
{
	if (self=[super init]) {
		_memoryCache = [[SXCache alloc] init];
        _memoryCache.autoRelease=YES;
	}
	return self;
}

+(SXImageCache*)sharedImageCache
{
	static SXImageCache* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SXImageCache alloc] init];
    });
	return instance;
}

+(UIImage*)imageNamed:(NSString *)key
{
    if (!key) {
        return nil;
    }
    UIImage* image = [UIImage imageNamed:key];
#ifdef DEBUG
           if (!image){
               @try {
                   NSAssert(NO, @"why can't load image:%@ ?",key);
               }@catch (NSException *exception) {
                   //^_^
               }
           }
#endif
    return image;
}


+(UIImage*)imageColorWithHex:(UInt32)hex
{
    return [[self sharedImageCache] _imageColorWithHex:hex];
}

-(UIImage*)_imageColorWithHex:(UInt32)hex
{
    id key = @(hex);
    UIImage *image =[_memoryCache objectForKey:key];
    if (image) {
        return image;
    }
    image = [UIImage imageByColor:[UIColor colorWithHex:hex]];
    [_memoryCache setObject:image forKey:key];
    return image;
}

-(BOOL)hasImageWithKey:(NSString*)key
{
	return ([_memoryCache objectForKey:key] != nil);
}

-(void)removeImageWithKey:(NSString *)key
{
	[_memoryCache removeObjectForKey:key];
}

-(void)dealloc
{
	_memoryCache = nil;
}

@end
