//
//  NSString+MD5String.m
//  tianqitong
//
//  Created by nova on 12-8-1.
//  Copyright (c) 2012年 nova . All rights reserved.
//

#import "NSString+MD5String.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5String)

- (NSString *)MD5String
{
    const char *str = [self UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5String = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return md5String;
}

@end
