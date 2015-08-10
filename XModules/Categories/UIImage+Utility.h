//
//  UIImage+Utility.h
//  RoundView
//
//  Created by nan4 li on 12-5-17.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3
} UIImageRoundedCorner;

@interface UIImage (Utility)

//+ (void)addRoundedRectToPath(CGContextRef context, CGRect rect, float radius, UIImageRoundedCorner cornerMask);
-(UIImage*)imageAdujstOrientation:(int) maxDimension;
-(UIImage*)addSubImage:(CGRect)rect subImage:(UIImage*)image;
- (UIImage *)roundedRectWith:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask;

@end
