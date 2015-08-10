//
//  SXButton+BarItem.h
//  SXClient
//
//  Created by iBcker on 15/4/7.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "SXButton.h"

@interface SXButton (BarItem)
+ (SXButton *)barItemViewTitle:(NSString *)text target:(id)target action:(SEL)sel;
+ (UIBarButtonItem *)barItemTitle:(NSString *)text target:(id)target action:(SEL)sel;
@end
