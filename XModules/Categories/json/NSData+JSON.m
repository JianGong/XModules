//
//  NSData+json.m
//  SXClient
//
//  Created by iBcker on 15/7/8.
//  Copyright © 2015年 SX. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)
- (id)json_obj
{
    return [NSJSONSerialization JSONObjectWithData:self options:0 error:NULL];
}
- (NSString *)json_string
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}
@end
