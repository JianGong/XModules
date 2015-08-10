//
//  NSString+humpName.m
//  SXClient
//
//  Created by iBcker on 14-10-10.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "NSString+humpName.h"

@implementation NSString (humpName)

- (NSString *)lowercaseHumpNameString
{
    NSMutableString *_str=[NSMutableString string];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (substringRange.location==0) {
            if ([substring hasUpperCharPrefix]) {
                [_str appendFormat:@"%c",[substring characterAtIndex:0]+32];
            }else{
                [_str appendString:substring];
            }
        }else{
            if ([substring hasUpperCharPrefix]) {
                [_str appendFormat:@"_%c",[substring characterAtIndex:0]+32];
            }else{
                [_str appendString:substring];
            }
        }
    }];
    return [_str copy];
}

- (BOOL)hasLowerCharPrefix
{
    if (self.length>0) {
        unichar c=[self characterAtIndex:0];
        if(c<'a'|| c>'z'){
            return NO;
        }else{
           return YES;
        }
    }else{
        return NO;
    }
}
- (BOOL)hasUpperCharPrefix
{
    if (self.length>0) {
        unichar c=[self characterAtIndex:0];
        if(c<'A'||c>'Z'){
            return NO;
        }else{
            return YES;
        }
    }else{
        return NO;
    }
}

@end
