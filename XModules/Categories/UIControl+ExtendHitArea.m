//
//  UIButton+ExtendHitArea.m
//  SXClient
//
//  Created by stcui on 13-7-22.
//
//

#import "UIControl+ExtendHitArea.h"
#import <objc/runtime.h>
#import "UIView+Sizes.h"

@implementation UIControl (ExtendHitArea)
@dynamic hitTestEdgeInsets;

#ifdef DEBUG
static NSString *const debugExtendHitArea;
-(void)setDebugExtendHitArea:(BOOL)show{
    objc_setAssociatedObject(self, &debugExtendHitArea, @(show), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)debugExtendHitArea {
    return [objc_getAssociatedObject(self, &debugExtendHitArea) boolValue];
}
#endif

static NSString *const KEY_HIT_TEST_EDGE_INSETS;

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
#ifdef DEBUG
    if (self.debugExtendHitArea) {
        UIEdgeInsets inset = self.hitTestEdgeInsets;
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(inset.left, inset.top, self.width-(inset.left+inset.right), self.height-(inset.top+inset.bottom))];
        
        border.layer.borderColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5].CGColor;
        border.layer.borderWidth=0.5;
        border.backgroundColor=[UIColor clearColor];
        border.userInteractionEnabled=NO;
        NSInteger tag = 997653;
        border.tag=tag;

        [self addSubview:border];
        double delayInSeconds = 3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [[self viewWithTag:tag] removeFromSuperview];
        });
    }
#endif
    
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) ||
       !self.enabled ||
       self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}
@end
