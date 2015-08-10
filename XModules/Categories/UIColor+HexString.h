//
//  UIColor+HexString.h
//  SXClient
//
//  Created by iBcker on 14-9-13.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
//根据rgb返回颜色;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexARGBString:(NSString *)inColorString;
+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(float)alpha;
@end
