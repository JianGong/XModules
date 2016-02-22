
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
    NSInteger _timeToTotle;
    NSInteger _timeToPass;
    
    _delayButtonTitleBlock _title;
    _delayButtonCompleteBlock _complete;
}

- (void)setDelay:(NSInteger)time title:(_delayButtonTitleBlock)title complete:(_delayButtonCompleteBlock)complete
{
    _title=title;
    _timeToTotle=time;
    _timeToPass = 0;
    _complete=complete;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGoes) userInfo:nil repeats:YES];
    [self timeGoes];
    [self.titleLabel sx_animatesFake];
    _delaying=YES;
}

- (void)stopSetDelayTitle
{
    _timeToPass = _timeToTotle;
    [self applyTitle];
    if (_complete) {
        [_timer invalidate];
        _timer=nil;
        _delaying=NO;
        _complete(NO);
        _complete=nil;
    }
}

- (void)applyTitle
{
    if (_title) {
        NSString *title = _title(_timeToTotle,_timeToPass);
        [self setTitle:title forState:UIControlStateNormal];
    }

    [self.titleLabel sx_animatesFake];
}

- (void)timeGoes
{
    [self applyTitle];
    if (_timeToPass>=_timeToTotle) {
        if (_complete) {
            [_timer invalidate];
            _timer=nil;
            _delaying=NO;
            _complete(YES);
            _complete=nil;
        }
    }
    _timeToPass++;
}
@end
