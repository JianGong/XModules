//
//  NSString+URL.m
//  SXClient
//
//  Created by iBcker on 14-6-11.
//
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)urlEncode {
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)urlDecode {
    return [self urlDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}


- (NSDictionary *)urlQuery
{
    NSString *origin = self;
    NSRange range =  [self rangeOfString:@"#"];
    if (range.location!=NSNotFound) {
        origin=[origin substringToIndex:range.location];
    }
    range = [origin rangeOfString:@"?"];
    NSMutableDictionary *ps = [NSMutableDictionary dictionary];
    
    if (range.location!=NSNotFound) {
        NSString *suffixStr =[origin substringFromIndex:range.location+1];
        NSArray *pars = [suffixStr componentsSeparatedByString:@"&"];
        [pars enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * __nonnull stop) {
            if (obj.length>0) {
                NSArray *kvs = [obj componentsSeparatedByString:@"="];
                if (kvs.count>=2) {
                    ps[kvs[0]]=kvs[1];
                }else{
                    if ([[kvs firstObject] length]>0) {
                        ps[[kvs firstObject]]=@"";
                    }
                }
            }
        }];
    }
    
    return [ps copy];
}

- (NSString *)urlPath;
{
    NSString *url = self;
    NSRange range =  [self rangeOfString:@"#"];
    if (range.location!=NSNotFound) {
        url=[url substringToIndex:range.location];
    }
    range = [url rangeOfString:@"?"];
    if (range.location!=NSNotFound){
        url=[url substringToIndex:range.location];
    }
    return url;
}

- (NSString *)urlAnchor
{
    NSString *anchor = @"";
    NSRange range =  [self rangeOfString:@"#"];
    if (range.location!=NSNotFound) {
        anchor=[self substringFromIndex:range.location+1];
    }
    return anchor;
}

@end
