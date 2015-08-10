//
//  SXCancelPan.m
//  PPeng
//
//  Created by iBcker on 15/6/10.
//  Copyright © 2015年 SX. All rights reserved.
//

#import "SXCancelPan.h"
@interface SXCancelPan()
@property (nonatomic)UITextField *holder;
@end

@implementation SXCancelPan

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addAction];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addAction];
}

- (void)addAction
{
    self.holder=[[UITextField alloc] init];
    [self addSubview:self.holder];
    self.holder.hidden=YES;
    [self addTarget:self action:@selector(onTap) forControlEvents:UIControlEventAllEvents];
}


- (void)onTap
{
    [self.holder becomeFirstResponder];
    [self.holder resignFirstResponder];
//    [self becomeFirstResponder];
//    [self resignFirstResponder];
}

//- (BOOL)canResignFirstResponder
//{
//    return YES;
//}
//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

@end
