//
//  UIView+sideBorder.m
//  rongxue
//
//  Created by iBcker on 15/7/10.
//  Copyright © 2015年 ibcker. All rights reserved.
//

#import "UIView+sideBorder.h"
#import <objc/runtime.h>

@implementation UIView (sideBorder)
- (UIView *)_sideLeftBorder
{
    return objc_getAssociatedObject(self, @"_sideLeftBorder");
}
- (void)set_sideLeftBorder:(UIView *)_sideLeftBorder
{
    objc_setAssociatedObject(self, @"_sideLeftBorder", _sideLeftBorder, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)_defaultBorderColor
{
    return [UIColor colorWithWhite:0.5 alpha:0.1];
}

-(void)setLeftBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight
{
    UIView *border=self._sideLeftBorder;
    if (!border&&show) {
        border = [[UIView alloc] init];
    }
    border.hidden=!show;
    border.backgroundColor=color;
    border.frame=CGRectMake(inset.left, inset.top, weight, self.frame.size.height-inset.top-inset.bottom);
    border.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:border];
    self._sideLeftBorder=border;
}

-(void)setLeftBorder:(BOOL)show color:(UIColor *)color
{
    [self setLeftBorder:show color:color weight:1];
}

-(void)setLeftBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight
{
    [self setLeftBorder:show color:color inset:UIEdgeInsetsZero weight:weight];
}

-(void)setLeftBorder:(BOOL)show
{
    [self setLeftBorder:show color:[self _defaultBorderColor]];
}

///////////////////top

- (UIView *)_sideTopBorder
{
    return objc_getAssociatedObject(self, @"_sideTopBorder");
}
- (void)set_sideTopBorder:(UIView *)_sideTopBorder
{
    objc_setAssociatedObject(self, @"_sideTopBorder", _sideTopBorder, OBJC_ASSOCIATION_RETAIN);
}

-(void)setTopBorder:(BOOL)show
{
    [self setTopBorder:show color:[self _defaultBorderColor]];
}

-(void)setTopBorder:(BOOL)show color:(UIColor *)color
{
    [self setTopBorder:show color:color weight:1];
}
-(void)setTopBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight
{
    [self setTopBorder:show color:color inset:UIEdgeInsetsZero weight:weight];
}
-(void)setTopBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight
{
    UIView *border=self._sideTopBorder;
    if (!border&&show) {
        border = [[UIView alloc] init];
    }
    border.hidden=!show;
    border.backgroundColor=color;
    border.frame=CGRectMake(inset.left, inset.top, self.frame.size.width-inset.left-inset.right, weight);
    border.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:border];
    self._sideTopBorder=border;
}


///////bottom
- (UIView *)_sideBottomBorder
{
    return objc_getAssociatedObject(self, @"_sideBottomBorder");
}
- (void)set_sideBottomBorder:(UIView *)_sideBottomBorder
{
    objc_setAssociatedObject(self, @"_sideBottomBorder", _sideBottomBorder, OBJC_ASSOCIATION_RETAIN);
}

-(void)setBottomBorder:(BOOL)show
{
    [self setBottomBorder:show color:[UIColor colorWithWhite:0.6 alpha:0.1]];
}

-(void)setBottomBorder:(BOOL)show color:(UIColor *)color
{
    [self setBottomBorder:show color:color weight:1];
}
-(void)setBottomBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight
{
    [self setBottomBorder:show color:color inset:UIEdgeInsetsZero weight:weight];
}
-(void)setBottomBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight
{
    UIView *border=self._sideBottomBorder;
    if (!border&&show) {
        border = [[UIView alloc] init];
    }
    border.hidden=!show;
    border.backgroundColor=color;
    border.frame=CGRectMake(inset.left,self.bounds.size.height-inset.bottom-weight,self.frame.size.width-inset.left-inset.right, weight);
    border.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:border];
    self._sideBottomBorder=border;
}


///////right
- (UIView *)_sideRightBorder
{
    return objc_getAssociatedObject(self, @"_sideRightBorder");
}
- (void)set_sideRightBorder:(UIView *)_sideRightBorder
{
    objc_setAssociatedObject(self, @"_sideRightBorder", _sideRightBorder, OBJC_ASSOCIATION_RETAIN);
}

-(void)setRightBorder:(BOOL)show
{
    [self setRightBorder:show color:[UIColor colorWithWhite:0.6 alpha:0.1]];
}

-(void)setRightBorder:(BOOL)show color:(UIColor *)color
{
    [self setRightBorder:show color:color weight:1];
}
-(void)setRightBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight
{
    [self setRightBorder:show color:color inset:UIEdgeInsetsZero weight:weight];
}
-(void)setRightBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight
{
    UIView *border=self._sideRightBorder;
    if (!border&&show) {
        border = [[UIView alloc] init];
    }
    border.hidden=!show;
    border.backgroundColor=color;
    border.frame=CGRectMake(self.bounds.size.width-inset.right-weight,inset.top,weight, self.bounds.size.height-inset.top-inset.bottom);
    border.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:border];
    self._sideRightBorder=border;
}

@end
