//
//  SXBarItem.m
//  SXClient
//
//  Created by iBcker on 14-9-13.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXBarItem.h"

@implementation SXBarItem

-(id)initWithTarget:(id)target action:(SEL)action
{
    self.action = action;
    self.target = target;
    if(self = [self initWithCustomView:[self barCustomView]]){
        
    }
    return self;
}

-(UIButton *)barCustomView
{
    return [[UIButton alloc] initWithFrame:CGRectZero];
}


@end
