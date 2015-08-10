//
//  SWDebugStatusBar.h
//  SinaWeather
//
//  Created by stcui on 13-9-2.
//
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface SWDebugStatusBar : UIWindow
DEF_SINGLETON
@property (readonly, nonatomic) UIButton *debugButton;

+ (void)attach;
@end
