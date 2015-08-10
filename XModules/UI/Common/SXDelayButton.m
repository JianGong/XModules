
//
//  SXDelayButton.m
//  
//
//  Created by iBcker on 15/6/14.
//
//

#import "SXDelayButton.h"
#import "UIView+sxAnimate.h"


@implementation SXDelayButton
{
    NSTimer *_timer;
    NSInteger _timeToInval;
    
    NSString *_title;
    _delayButtonCompleteBlock _complete;
}

- (void)setDelay:(NSInteger)time title:(NSString *)title complete:(_delayButtonCompleteBlock)complete;
{
    _title=title;
    _timeToInval=time;
    _complete=complete;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGoes) userInfo:nil repeats:YES];
    [self timeGoes];
    [self.titleLabel sx_animatesFake];
    _delaying=YES;
}

- (void)stopSetDelayTitle
{
    [self applyTitle];
    if (_complete) {
        _complete(NO);
        _complete=nil;
    }
}

- (void)applyTitle
{
    [_timer invalidate];
    _timer=nil;
    [self setTitle:_title forState:UIControlStateNormal];
    [self.titleLabel sx_animatesFake];
    _title=nil;
    _delaying=NO;
}

- (void)timeGoes
{
    if (_timeToInval<0) {
        [self applyTitle];
        if (_complete) {
            _complete(YES);
            _complete=nil;
        }
    }else{
        NSString *title = [NSString stringWithFormat:@"%zd\"",_timeToInval];
        [self setTitle:title forState:UIControlStateNormal];
    }
    _timeToInval--;
}
@end
