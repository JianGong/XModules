//
//  SWImageCache.h
//  SinaWeather
//
//  Created by iBcker on 14-6-25.
//
//



//图片缓存类
#import <UIKit/UIKit.h>

#define SXIMAGE(name) [SXImageCache imageNamed:name]
#define SXIMAGEHEX(hex) [SXImageCache imageColorWithHex:hex]

@class UIColor;
@interface SXImageCache : NSObject

+(SXImageCache*)sharedImageCache;
+(UIImage*)imageNamed:(NSString *)name;
+(UIImage*)imageColorWithHex:(UInt32)hex;

-(BOOL)hasImageWithKey:(NSString*)key;//检测某图片是否已加入到缓存
-(void)removeImageWithKey:(NSString *)key;//从缓存中删除某图片

@end
