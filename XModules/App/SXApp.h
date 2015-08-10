//
//  SXApp.h
//  SXClient
//
//  Created by iBcker on 14/12/19.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *SXLocalString(NSString *key);
extern NSString *appBuildVersion(void);
extern NSString *appVersion(void);
extern NSString *platName(void);
extern NSString *udid(void);
extern NSString *sxResolution(void);

extern NSDictionary *SXHTTPPARS(NSDictionary *pars);

@interface SXApp : NSObject
+ (NSString *)udid;
@end
