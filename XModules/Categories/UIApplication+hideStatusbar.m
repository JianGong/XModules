//
//  UIApplication+hideStatusbar.m
//  SXClient
//
//  Created by iBcker on 14-9-15.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "UIApplication+hideStatusbar.h"

@implementation UIApplication (hideStatusbar)

- (void)_setStatusBarHidden:(BOOL)hidden withAnimation:(BOOL)animation
{
    UIView *bar = [self sysStatusBar];
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            bar.alpha=hidden?0:1;
        }];
    }else{
        bar.alpha=hidden?0:1;
    }
    self.sysStatusBar.userInteractionEnabled=!hidden;
}

- (UIView *)sysStatusBar
{
    UIView *bar;
    @try {
        bar=[[UIApplication sharedApplication] valueForKey:@"_statusBar"];
    }@catch (NSException *exception) {}
    return bar;
}

- (UIView *)sysStatusBarForegroundView
{
    NSArray *vs=[self.sysStatusBar subviews];
    Class clazz=NSClassFromString(@"UIStatusBarForegroundView");
    for (id v in vs) {
        if ([v isKindOfClass:clazz]) {
            return v;
        }
    }
    return nil;
}


@end
