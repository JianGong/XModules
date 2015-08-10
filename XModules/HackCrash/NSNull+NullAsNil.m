//
//  NSNull+NullAsNil.m
//  SXClient
//
//  Created by cui on 13-5-23.
//
//

#import "NSNull+NullAsNil.h"
#import <objc/runtime.h>

static int zero(id self, SEL cmd) {
    return 0;
}

@implementation NSNull (NullAsNil)
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod([self class], sel, (IMP)zero, "v@:");
    return YES;
}
@end
