//
//  UIColor+HexString.m
//  SXClient
//
//  Created by iBcker on 14-9-13.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)
+ (UIColor *)colorWithHexString:(NSString *)inColorString
{
    static NSMutableDictionary *_cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cache = [[NSMutableDictionary alloc] initWithCapacity:32];
    });
    
    inColorString = [inColorString lowercaseString];
    UIColor *color;
    @synchronized(@"colorWithHexString"){
        color = [_cache objectForKey:inColorString];
    }
    if (color) return color;
    
    unsigned colorCode =0;
    CGFloat alpha = 1.0;
    unsigned char redByte, greenByte, blueByte;
    if ([inColorString hasPrefix:@"#"]) {
        inColorString=[inColorString substringFromIndex:1];
    }
    NSUInteger leng=inColorString.length;
    if (leng==3) {
        redByte=[inColorString characterAtIndex:0];
        greenByte=[inColorString characterAtIndex:1];
        blueByte=[inColorString characterAtIndex:2];
        inColorString =[NSString stringWithFormat:@"%c%c%c%c%c%c",redByte,redByte,greenByte,greenByte,blueByte,blueByte];
    }
    if (nil != inColorString)
    {
        NSScanner* scanner = [NSScanner scannerWithString:inColorString];
        [scanner scanHexInt:&colorCode]; // ignore error
    }
    
    if(leng==8){
        alpha = ((CGFloat)((unsigned char)(colorCode)))/ 0xff;
        redByte = (unsigned char)(colorCode >> 24);
        greenByte = (unsigned char)(colorCode >> 16);
        blueByte = (unsigned char)(colorCode >> 8); // masks off high bits
    }else{
        redByte = (unsigned char)(colorCode >> 16);
        greenByte = (unsigned char)(colorCode >> 8);
        blueByte = (unsigned char)(colorCode); // masks off high bits
    }
    color = [UIColor colorWithRed:(CGFloat)redByte / 0xff green:(CGFloat)greenByte / 0xff blue:(CGFloat)blueByte / 0xff alpha:alpha];
    @synchronized(@"colorWithHexString"){
        [_cache setValue:color forKey:inColorString];
    }
    return color;
}

+ (UIColor *)colorWithHexARGBString:(NSString *)inColorString
{
    if (nil == inColorString) return nil;
    static NSMutableDictionary *_cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cache = [[NSMutableDictionary alloc] initWithCapacity:32];
    });
    
    inColorString = [inColorString lowercaseString];
    UIColor *color;
    
    @synchronized(@"colorWithHexARGBString"){
        color = [_cache objectForKey:inColorString];
    }
    
    if (color) return color;
    
    unsigned colorCode =0;
    CGFloat alpha = 1.0;
    unsigned char redByte, greenByte, blueByte;
    if ([inColorString hasPrefix:@"#"]) {
        inColorString=[inColorString substringFromIndex:1];
    }
    NSUInteger leng=inColorString.length;
    if (leng==3) {
        redByte=[inColorString characterAtIndex:0];
        greenByte=[inColorString characterAtIndex:1];
        blueByte=[inColorString characterAtIndex:2];
        inColorString =[NSString stringWithFormat:@"%c%c%c%c%c%c",redByte,redByte,greenByte,greenByte,blueByte,blueByte];
    }
    if (nil != inColorString)
    {
        NSScanner* scanner = [NSScanner scannerWithString:inColorString];
        [scanner scanHexInt:&colorCode]; // ignore error
    }
    
    if(leng==8){
        alpha = ((CGFloat)((unsigned char)(colorCode>>24)))/ 0xff;
        redByte = (unsigned char)(colorCode >> 16);
        greenByte = (unsigned char)(colorCode >> 8);
        blueByte = (unsigned char)(colorCode); // masks off high bits
    }else{
        redByte = (unsigned char)(colorCode >> 16);
        greenByte = (unsigned char)(colorCode >> 8);
        blueByte = (unsigned char)(colorCode); // masks off high bits
    }
    color = [UIColor colorWithRed:(CGFloat)redByte / 0xff green:(CGFloat)greenByte / 0xff blue:(CGFloat)blueByte / 0xff alpha:alpha];
    
    @synchronized(@"colorWithHexARGBString"){
        [_cache setValue:color forKey:inColorString];
    }
    return color;
}

+ (UIColor *)colorWithHex:(UInt32)hex
{
    return [UIColor colorWithHex:hex alpha:1];
}

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(float)alpha
{
    CGFloat r = ((hex & 0xff0000) >> 16) / 255.f;
    CGFloat g = ((hex & 0x00ff00) >> 8) / 255.f;
    CGFloat b = (hex & 0x0000ff) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}
@end
