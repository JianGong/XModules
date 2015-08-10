//
//  SXButton+BarItem.m
//  SXClient
//
//  Created by iBcker on 15/4/7.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "SXButton+BarItem.h"
#import "UIView+Sizes.h"

@implementation SXButton (BarItem)
+ (instancetype)barItemViewTitle:(NSString *)text target:(id)target action:(SEL)sel
{
    SXButton *button = [[SXButton alloc] initWithFrame:CGRectMake(0, 0, 49, 40)];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (target&&sel) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    [button sizeToFit];
    button.width=button.width+10;
    return button;
}
+ (UIBarButtonItem *)barItemTitle:(NSString *)text target:(id)target action:(SEL)sel
{
    SXButton *button = [self barItemViewTitle:text target:target action:sel];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
