//
//  SXGradientView.m
//  PPeng
//
//  Created by iBcker on 15/7/7.
//  Copyright © 2015年 实现. All rights reserved.
//

#import "SXGradientView.h"

@implementation SXGradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (void)setColors:(NSArray *)colors
{
    _colors=[colors copy];
    CAGradientLayer *layer = (id)self.layer;
    layer.colors=colors;
}

- (void)setLocations:(NSArray *)locations
{
    _locations=[locations copy];
    CAGradientLayer *layer = (id)self.layer;
    layer.locations=locations;
}

- (void)setStartPoint:(CGPoint)startPoint
{
    _startPoint=startPoint;
    CAGradientLayer *layer = (id)self.layer;
    layer.startPoint=startPoint;
}

- (void)setEndPoint:(CGPoint)endPoint
{
    _endPoint=endPoint;
    CAGradientLayer *layer = (id)self.layer;
    layer.endPoint=_endPoint;
}

@end
