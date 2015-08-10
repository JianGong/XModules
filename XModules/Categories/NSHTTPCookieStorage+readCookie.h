//
//  NSHTTPCookieStorage+readCookie.h
//  WatchingMovie
//
//  Created by iBcker on 13-12-22.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPCookieStorage (readCookie)

- (NSHTTPCookie *)cookiesByUrl:(NSString *)url name:(NSString *)name;

- (void)removeCookiesInDomain:(NSString *)domain;
- (void)removeCookiesInDomain:(NSString *)domain name:(NSString *)key;
- (void)synCookies;

@end
