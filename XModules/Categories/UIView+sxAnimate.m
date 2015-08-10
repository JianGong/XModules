//
//  UIView+sxAnimate.m
//  SXClient
//
//  Created by iBcker on 15/3/2.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "UIView+sxAnimate.h"

@implementation UIView (sxAnimate)
- (void)sx_animatesShake
{
    [self sx_animatesFakeDuration:0.07];
}
- (void)sx_animatesShakeDuration:(CGFloat)duration
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-5];
    shake.toValue = [NSNumber numberWithFloat:5];
    shake.duration = duration;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 2;//次数
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

- (void)sx_animatesFake
{
    [self sx_animatesFakeDuration:0.3];
}

- (void)sx_animatesFakeDuration:(CGFloat)duration
{
    CATransition* animation = [CATransition animation];
    animation.duration = duration;
    animation.type = kCATransitionFade;
    [self.layer addAnimation:animation forKey:@"fade"];
}
@end
