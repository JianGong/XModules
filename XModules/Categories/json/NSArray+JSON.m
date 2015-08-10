//
//  NSArray+json.m
//  
//
//  Created by iBcker on 15/6/17.
//
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)
- (NSData *)json_data
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    }else{
        return nil;
    }
}

- (NSString *)json_string
{
    NSData *data = [self json_data];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}
@end
