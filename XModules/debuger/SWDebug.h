//
//  SWDebug.h
//  SinaWeather
//
//  Created by stcui on 13-9-2.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct {
    natural_t used;
    natural_t free;
} SWMemroyInfo;

@interface SWDebug : NSObject
+ (NSString *)memoryUsageDescription;
+ (SWMemroyInfo)memoryInfo;

+ (UIView *)sysStatusBarBgView;
+ (UIView *)sysStatusBar;
@end
