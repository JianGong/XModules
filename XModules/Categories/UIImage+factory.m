//
//  UIImage+factory.m
//  Maotachi
//
//  Created by iBcker on 13-10-26.
//  Copyright (c) 2013年 lc. All rights reserved.
//

#import "UIImage+factory.h"

@implementation UIImage (factory)

+ (UIImage *)imageByColor:(UIColor *)cl
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    [cl set];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image stretchableImageWithLeftCapWidth:1 topCapHeight:1];
}

@end
