//
//  UIView+sxAnimate.h
//  SXClient
//
//  Created by iBcker on 15/3/2.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (sxAnimate)
- (void)sx_animatesShake;
- (void)sx_animatesShakeDuration:(CGFloat)duration;

- (void)sx_animatesFake;
- (void)sx_animatesFakeDuration:(CGFloat)duration;
@end
