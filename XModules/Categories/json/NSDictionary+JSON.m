//
//  NSDictionary+SX_JSONData.m
//  
//
//  Created by iBcker on 15/6/17.
//
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

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
