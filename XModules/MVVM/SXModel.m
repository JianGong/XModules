//
//  SXModel.m
//  SXClient
//
//  Created by iBcker on 14-10-10.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXModel.h"
#import "SXUtilities.h"

@implementation SXModel

+ (id)fillObj:(NSDictionary *)dix
{
    return [self fillObj:dix after:nil];
}

+ (id)fillObj:(NSDictionary *)dix after:(id (^)(id obj,NSDictionary *item))after
{
    if (!isNSDictionary(dix)) {
        dix=nil;
        if (after) {
            after(nil,dix);
        }
        return nil;
    }
    SXModel *obj=[[[self class] alloc] initWithDictionary:dix];
    
    NSDictionary *properties=[obj codableProperties];
    [properties enumerateKeysAndObjectsUsingBlock:^(NSString *key, ATCPropertyAttr *attr, BOOL *stop) {
        Class clazz=attr.clazz;
        id data=dix[key];
        if([clazz isSubclassOfClass:[SXModel class]]){
            if (data) {
                obj[key]=[clazz fillObj:data after:nil];
            }
        }else if (attr.protocol&&[clazz isSubclassOfClass:[NSArray class]]&&[data isKindOfClass:[NSArray class]]){
            Class factor=NSClassFromString(attr.protocol);
            if ([factor isSubclassOfClass:[SXModel class]]) {
                NSMutableArray *items = [NSMutableArray array];
                for (NSDictionary *item in (NSArray*)data) {
                    if (isNSDictionary(item)) {
                        SXModel *_obj=[factor fillObj:item after:nil];
                        if (_obj) {
                            [items addObject:_obj];
                        }
                    }
                }
                obj[key]=items;
            }
        }else if([clazz isSubclassOfClass:[NSURL class]]){
            NSString *urlStr=dix[key];
            if ([urlStr isKindOfClass:[NSString class]]) {
                NSURL *url=[NSURL URLWithString:urlStr];
                obj[key]=url;
            }
        }else if([clazz isSubclassOfClass:[NSDate class]]){
            NSString *dateStr=dix[key];
            if ([dateStr isKindOfClass:[NSString class]]) {
                NSDate *date=[self strToDate:dateStr];
                if (date) {
                    obj[key]=date;
                }
            }
        }else if ([clazz isSubclassOfClass:[NSNumber class]]){
            NSString *vaule=dix[key];
            if ([vaule isKindOfClass:[NSString class]]) {
                NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
                formater.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *_vaule = [formater numberFromString:vaule];
                if (_vaule) {
                    obj[key]=_vaule;
                }
            }
        }else if([clazz isSubclassOfClass:[NSString class]]){
            NSNumber *vaule=dix[key];
            if ([vaule isKindOfClass:[NSNumber class]]) {
                NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
                formater.numberStyle = NSNumberFormatterDecimalStyle;
                NSString *_vaule = [formater stringFromNumber:vaule];
                if (_vaule) {
                    obj[key]=_vaule;
                }
            }
        }
    }];
    
    if (after) {
        obj=after(obj,dix);
    }
    [self afterFill:obj info:dix];
    return obj;
}

+ (void)afterFill:(SXModel *)obj info:(NSDictionary *)item
{
    
}

+ (NSArray *)fillObjs:(NSArray *)arr each:(id (^)(id obj,NSDictionary *item))callback
{
    NSMutableArray *res;
    if (isNSArray(arr)) {
        res=[NSMutableArray array];
        for (NSDictionary *item in arr) {
            if (isNSDictionary(item)) {
                SXModel *obj = [self fillObj:item after:callback];
                if(obj){
                    [res addObject:obj];
                }
            }
        }
    }
    return [res copy];
}

+ (NSDate *)strToDate:(NSString *)dateStr
{
    if (![dateStr isKindOfClass:[NSString class]]) {
        return nil;
    }
    static NSDateFormatter *formater=nil;
    static dispatch_once_t onceToken;
    static dispatch_queue_t dayStrQ = nil;
    dispatch_once(&onceToken, ^{
        formater = [[NSDateFormatter alloc] init];
        [formater setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];
        dayStrQ=dispatch_queue_create("sx.model.dateformater", DISPATCH_QUEUE_SERIAL);
    });
    __block NSDate *date;
    dispatch_sync(dayStrQ, ^{
        NSString *dateFormat = [self dateFormat];
        if (![formater.dateFormat isEqualToString:dateFormat]) {
            formater.dateFormat=dateFormat;
        }
        NSTimeZone *timeZone = [self dateFormatTimeZone];
        if (![formater.timeZone isEqualToTimeZone:timeZone]) {
            [formater setTimeZone:timeZone];
        }
        date=[formater dateFromString:dateStr];
    });
    return date;
}

+ (NSString *)dateFormat
{
    return @"yyyy-MM-dd'T'HH:mm:sszzz";
}

+ (NSTimeZone *)dateFormatTimeZone
{
    return [NSTimeZone systemTimeZone];
}

@end
