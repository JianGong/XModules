//
//  ProgressView.m
//  Test
//
//  Created by lc on 3/15/13.
//  Copyright (c) 2013 lc. All rights reserved.
//

#import "ProgressView.h"

//#define RGBA(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]
#define PROGRESS_WIDTH 3

@implementation ProgressView

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 40, 40)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _linkBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _linkColor = [UIColor whiteColor];
        _linkWidth = PROGRESS_WIDTH;
        _lineCapStyle = kCGLineCapRound;
        _disMissWhenCompleted = YES;
        _progress = 0.025;
        _progressOffset = -0.0125;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{ 
    if (progress != _progress) {
        _progress = MIN(1,MAX(0.025,progress));
        [self setNeedsDisplay];
        [self autoDisMissWhenCompleted];
    }
}

- (void)autoDisMissWhenCompleted
{
    if(_disMissWhenCompleted && _progress > 0.999 && self.superview) {
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
    }
}

- (void)setLinkBackgroundColor:(UIColor *)linkBackgroundColor
{
    _linkBackgroundColor = linkBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setLinkColor:(UIColor *)linkColor
{
    _linkColor = linkColor;
    [self setNeedsDisplay];
}

- (void)setLinkWidth:(CGFloat)linkWidth
{
    if(_linkWidth != linkWidth){
        _linkWidth = linkWidth;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2);
    CGFloat radius = self.bounds.size.width / 2 - PROGRESS_WIDTH / 2 - 1;
    CGFloat startAngle =  -M_PI_2 + (self.progressOffset * 2 * M_PI);
    CGFloat endAngle = 1.5 * M_PI + (self.progressOffset * 2 * M_PI);

    //draw background circle
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:startAngle
                                                            endAngle:endAngle
                                                           clockwise:YES];
    [self.linkBackgroundColor setStroke];
    backCircle.lineWidth = self.linkWidth;
    [backCircle stroke];

    if (self.progress > 0) {        //draw progress circle
        endAngle = (CGFloat)(startAngle + self.progress * 2 * M_PI);
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                      radius:radius
                                                                  startAngle:startAngle
                                                                    endAngle:endAngle
                                                                   clockwise:YES];
        [self.linkColor setStroke];
        progressCircle.lineWidth = self.linkWidth*0.6;
        progressCircle.lineCapStyle = self.lineCapStyle;
        [progressCircle stroke];
    }

}


@end
