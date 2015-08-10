//
//  NSString+trim.m
//  SXClient
//
//  Created by iBcker on 15/3/2.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "NSString+trim.h"

@implementation NSString (trim)
- (NSString *)sx_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
