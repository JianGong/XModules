//
//  SWDebugSysCtl.h
//  SinaWeather
//
//  Created by iBcker on 13-9-3.
//
//

#import <Foundation/Foundation.h>

@interface SWDebugSysCtl : NSObject

+ (NSString *) platform;

+ (NSUInteger) getSysInfo: (uint) typeSpecifier;

//获取CPU频率
+ (NSUInteger) getCpuFrequency;

//获取总线频率
+ (NSUInteger) getBusFrequency;

//获取总的内存大小
+ (NSUInteger) getTotalMemory;

//获取用户内存
+ (NSUInteger) getUserMemory;

//获取socketBufferSize
+ (NSUInteger) maxSocketBufferSize;

//iphone下获取可用的内存大小
+ (NSUInteger)getAvailableMemory;

//获取CPU使用率
+(float)cpuUsage;

@end
