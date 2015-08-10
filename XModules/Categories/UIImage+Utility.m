#import "UIImage+Utility.h"

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float radius, UIImageRoundedCorner cornerMask)
{
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    if (cornerMask & UIImageRoundedCornerTopLeft) {
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                        radius, M_PI, M_PI / 2, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y + rect.size.height);
    }

    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);

    if (cornerMask & UIImageRoundedCornerTopRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                        rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - radius);
    }

    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);

    if (cornerMask & UIImageRoundedCornerBottomRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                        radius, 0.0f, -M_PI / 2, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y);
    }

    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);

    if (cornerMask & UIImageRoundedCornerBottomLeft) {
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                        -M_PI / 2, M_PI, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + radius);
    }

    CGContextClosePath(context);
}

@implementation UIImage (Utility)
-(UIImage*)imageAdujstOrientation:(int) maxDimension
{
	CGImageRef imgRef = self.CGImage;  
	
	CGFloat width = CGImageGetWidth(imgRef);  
	CGFloat height = CGImageGetHeight(imgRef);  
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);  
	
	if(maxDimension > 0) //need scale
	{
		if (width > maxDimension || height > maxDimension) 
		{  
			CGFloat ratio = width/height;  
			if (ratio > 1)
			{  
				bounds.size.width = maxDimension;  
				bounds.size.height = bounds.size.width / ratio;  
			}  
			else
			{  
				bounds.size.height = maxDimension;  
				bounds.size.width = bounds.size.height * ratio;  
			}  
		}
	}
	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));  
    CGFloat boundHeight;  
	
	UIImageOrientation orient = self.imageOrientation;  
    switch(orient) 
	{  
        case UIImageOrientationUp: //EXIF = 1  
            transform = CGAffineTransformIdentity;  
            break;  
			
        case UIImageOrientationUpMirrored: //EXIF = 2  
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);  
            transform = CGAffineTransformScale(transform, -1.0, 1.0);  
            break;  
			
        case UIImageOrientationDown: //EXIF = 3  
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);  
            transform = CGAffineTransformRotate(transform, M_PI);  
            break;  
			
        case UIImageOrientationDownMirrored: //EXIF = 4  
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);  
            transform = CGAffineTransformScale(transform, 1.0, -1.0);  
            break;  
			
        case UIImageOrientationLeftMirrored: //EXIF = 5  
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);  
            transform = CGAffineTransformScale(transform, -1.0, 1.0);  
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);  
            break;  
			
        case UIImageOrientationLeft: //EXIF = 6  
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);  
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);  
            break;  
			
        case UIImageOrientationRightMirrored: //EXIF = 7  
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformMakeScale(-1.0, 1.0);  
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);  
            break;  
			
        case UIImageOrientationRight: //EXIF = 8  
            boundHeight = bounds.size.height;  
            bounds.size.height = bounds.size.width;  
            bounds.size.width = boundHeight;  
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);  
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);  
            break;  
			
        default:  
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];  
			
    }  
	
    UIGraphicsBeginImageContext(bounds.size);
	
    CGContextRef context = UIGraphicsGetCurrentContext();  
	
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
	{
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);  
    }
    else
	{  
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);  
    }  
	
    CGContextConcatCTM(context, transform);  
	
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);  
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();  
	
    return imageCopy;
	
}

-(UIImage*)addSubImage:(CGRect)rect subImage:(UIImage*)image
{
    int w = self.size.width;
    int h = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    CGContextDrawImage(context, rect, image.CGImage);

    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return newImage;
    
}
- (UIImage *)roundedRectWith:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask
{
    int w = self.size.width;
    int h = self.size.height;
    CGRect imageFrame = CGRectMake(0, 0, w, h);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);

    CGContextBeginPath(context);
    //绘制弧线
    addRoundedRectToPath(context,imageFrame, radius, cornerMask);
    CGContextClosePath(context);
    
    //剪切
    CGContextClip(context);

    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);

    //绘制边框    
    CGContextBeginPath(context);
    addRoundedRectToPath(context,imageFrame, radius, cornerMask);
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 1.2);
    CGContextSetStrokeColorWithColor(context,[UIColor colorWithRed:0 green:0 blue:0 alpha:0.15].CGColor);
    CGContextStrokePath(context);
    //
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];

    CGImageRelease(imageMasked);

    return newImage;
}
@end
