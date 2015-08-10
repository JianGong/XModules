//
//  CGUtil.h
//  SXClient
//
//  Created by cui on 13-2-27.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

CGRect CGRectByChangeHeight(CGRect rect, CGFloat height);
CGRect CGRectForCenteringSize(CGSize container, CGSize content);
CGPoint CGRectGetCenter(CGRect rect);

CG_INLINE CGRect
CGRectMakeByRightY(CGFloat right, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.size.width = width; rect.size.height = height;
    rect.origin.x = right-width; rect.origin.y = y;
    return rect;
}

CG_INLINE CGRect
CGRectMakeByRightBottom(CGFloat right, CGFloat bootom, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.size.width = width; rect.size.height = height;
    rect.origin.x = right-width; rect.origin.y = bootom-height;
    return rect;
}

CG_INLINE CGRect
CGRectMakeByRightCenterY(CGFloat right, CGFloat cy, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.size.width = width; rect.size.height = height;
    rect.origin.x = right-width; rect.origin.y = cy-height/2.f;
    return rect;
}

CG_INLINE CGRect
CGRectMakeByLeftCenterY(CGFloat left, CGFloat cy, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.size.width = width; rect.size.height = height;
    rect.origin.x = left; rect.origin.y = cy-height/2.f;
    return rect;
}

CG_INLINE CGRect
CGRectMakeByXBootom(CGFloat x, CGFloat bootom, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.size.width = width; rect.size.height = height;
    rect.origin.x = x; rect.origin.y = bootom - height;
    return rect;
}

CG_INLINE CGRect
CGRectMakeByCenter(CGFloat centerX, CGFloat centerY, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.size.width = width; rect.size.height = height;
    rect.origin.x = centerX-width/2; rect.origin.y = centerY-height/2;
    return rect;
}
CG_INLINE CGRect
CGRectMakeByCenterXAndY(CGFloat centerX, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.size.width = width; rect.size.height = height;
    rect.origin.x = centerX-width/2; rect.origin.y = y;
    return rect;
}