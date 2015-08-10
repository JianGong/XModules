//
//  SXModel.h
//  SXClient
//
//  Created by iBcker on 14-10-10.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "ATCModel.h"

@interface SXModel : ATCModel

+ (NSArray *)fillObjs:(NSArray *)arr each:(id (^)(id ob,NSDictionary *item))callback;

+ (id)fillObj:(NSDictionary *)dix;
+ (id)fillObj:(NSDictionary *)dix after:(id (^)(id obj,NSDictionary *item))callback;

+ (void)afterFill:(SXModel *)obj info:(NSDictionary *)item;//empty implement

//可以复写实现时间转换
+ (NSDate *)strToDate:(NSString *)dateStr;
+ (NSString *)dateFormat;//default is yyyy-MM-dd'T'HH:mm:sszzz
+ (NSTimeZone *)dateFormatTimeZone; //default is [NSTimeZone systemTimeZone]

@end