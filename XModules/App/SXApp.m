//
//  SXApp.m
//  SXClient
//
//  Created by iBcker on 14/12/19.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXApp.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "NSString+MD5String.h"
#import <UIKit/UIKit.h>
#import "SXUtilities.h"

@implementation SXApp
+ (NSString *)udid
{
    static NSString *udid;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        udid = [[NSUserDefaults standardUserDefaults] objectForKey:@"SXUDID"];
        if (!isEffectiveNSString(udid)){
//            udid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if (!isEffectiveNSString(udid)) {
                udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            }
            if (isEffectiveNSString(udid)) {
                [[NSUserDefaults standardUserDefaults] setObject:udid forKey:@"SXUDID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                udid=@"";
            }
        }
    });
    return udid;
}
@end

NSString *SXLocalString(NSString *key){
    NSString *str=NSLocalizedString(key, nil);
    if (!isEffectiveNSString(str)||[str isEqualToString:key]) {
        str=[[key componentsSeparatedByString:@"->"] lastObject];
        //        NSAssert1(NO, @"有没本地话的数据%@",key);
    }
    return str;
}

NSDictionary *SXHTTPPARS(NSMutableDictionary *pars)
{
    if (![pars isKindOfClass:[NSMutableDictionary class]]) {
        if (pars) {
            pars=[pars mutableCopy];
        }else{
            pars=[NSMutableDictionary dictionary];
        }
    }
    
    pars[@"sx_plat"]=@"ios";
    NSString *name=platName();
    if (name) {
        pars[@"sx_platname"]=name;
    }
    pars[@"sx_appversion"]=appBuildVersion();
    pars[@"sx_osversion"]=[[UIDevice currentDevice] systemVersion];
    NSString *uid = udid();
    if (uid) {
        pars[@"sx_udid"]=uid;
    }
    
    pars[@"sx_resolution"]=sxResolution();
    pars[@"sx_ts"]=@(CFAbsoluteTimeGetCurrent());

    return pars;
}

NSString *sxResolution(void)
{
    static NSString *_resolution;
    if (nil == _resolution) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        int scale=[[UIScreen mainScreen] scale];
        _resolution = [NSString stringWithFormat:@"%.0f*%.0f",
                       size.width*scale, size.height*scale];
    }
    return _resolution;
}

NSString *appBuildVersion(void)
{
    static NSString *version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version=[[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey];
    });
    return version;
}

NSString *appVersion(void)
{
    static NSString *version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version=[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    });
    return version;
}

NSString *platName(void)
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *name = malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    free(name);
    return platform;
}

NSString *udid(void)
{
    return [SXApp udid];
}