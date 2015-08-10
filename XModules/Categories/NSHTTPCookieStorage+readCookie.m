//
//  NSHTTPCookieStorage+readCookie.m
//  WatchingMovie
//
//  Created by iBcker on 13-12-22.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import "NSHTTPCookieStorage+readCookie.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSHTTPCookieStorage (readCookie)

- (NSHTTPCookie *)cookiesByUrl:(NSString *)url name:(NSString *)name
{
    NSArray *cookies = [self cookiesForURL:[NSURL URLWithString:url]];
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:name]) {
            return cookie;
        }
    }
    return nil;
}

- (void)removeCookiesInDomain:(NSString *)domain
{
    [self removeCookiesInDomain:domain name:nil];
}

- (void)removeCookiesInDomain:(NSString *)domain name:(NSString *)key
{
    NSArray *cookies = [self cookiesForURL:[NSURL URLWithString:domain]];
    for (NSHTTPCookie *cookie in cookies) {
        if (key) {
            if ([cookie.name isEqualToString:key]) {
                [self deleteCookie:cookie];
                break;
            }
        }else{
            [self deleteCookie:cookie];
        }
    }
    [self synCookies];
}

- (void)synCookies
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL _method = NSSelectorFromString(@"_saveCookies");
    if([self respondsToSelector:_method]){
        [self performSelector:_method];
    }
    _method=nil;
#pragma clang diagnostic pop
}



@end
