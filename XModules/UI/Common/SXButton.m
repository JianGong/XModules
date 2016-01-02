//
//  SXButton.m
//  SXClient
//
//  Created by iBcker on 15/3/3.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "SXButton.h"
#import "UIColor+HexString.h"

@implementation SXButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHex:0xc0e1f2] forState:UIControlStateHighlighted];
        
        [self addTarget:self action:@selector(_onTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)_onTouchUpInside
{
    if (self.onTouchUpInside) {
        self.onTouchUpInside(self);
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    self.titleLabel.alpha=enabled?1:0.8;
}


@end
