//
//  NSString+URL.h
//  SXClient
//
//  Created by iBcker on 14-6-11.
//
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSString *)urlEncode;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)urlDecode;
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;


- (NSDictionary *)urlQuery;
- (NSString *)urlPath;
- (NSString *)urlAnchor;

@end
