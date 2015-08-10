//
//  NSString+isNumber.m
//  SXClient
//
//  Created by iBcker on 15/3/29.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "NSString+isNumber.h"

@implementation NSString (isNumber)
- (BOOL)isFullNumber
{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    return string.length == self.length;
}

@end
