//
//  NSString+json.m
//  
//
//  Created by iBcker on 15/6/17.
//
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
- (NSData *)json_data
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    }else{
        return nil;
    }
}

- (id)json_obj
{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
}
@end
