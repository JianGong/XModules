//
//  NSDictionary+urlquery.m
//  rongxue
//
//  Created by iBcker on 15/7/16.
//  Copyright © 2015年 ibcker. All rights reserved.
//

#import "NSDictionary+urlquery.h"

@implementation NSDictionary (urlquery)
- (NSString *)urlQueryString
{
    NSMutableArray *kps = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id  __nonnull key, id  __nonnull obj, BOOL * __nonnull stop) {
        [kps addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
    }];
    return [kps componentsJoinedByString:@"&"];
}
@end
