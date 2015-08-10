//
//  CGUtil.m
//  SXClient
//
//  Created by cui on 13-2-27.
//
//

#import "CGUtil.h"

CGRect CGRectByChangeHeight(CGRect rect, CGFloat height)
{
    rect.size.height = height;
    return rect;
}

CGRect CGRectForCenteringSize(CGSize container, CGSize content)
{
    CGRect rect;
    rect.origin = CGPointMake(roundf((container.width - content.width) / 2),
                              roundf((container.height - content.height) / 2));
    rect.size = content;
    return rect;
}

CGPoint CGRectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}
