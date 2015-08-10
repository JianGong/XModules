//
//  UIApplication+hideStatusbar.h
//  SXClient
//
//  Created by iBcker on 14-9-15.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (hideStatusbar)

- (UIView *)sysStatusBar;
- (void)_setStatusBarHidden:(BOOL)hidden withAnimation:(BOOL)animation;

@end
