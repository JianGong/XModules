//
//  UIView+hackHidden.m
//  SinaWeather
//
//  Created by iBcker on 14/12/30.
//
//

#import "UIView+hackHidden.h"

@implementation UIView (hackHidden)
- (BOOL)isShow
{
    return !self.isHidden;
}
@end