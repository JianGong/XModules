//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

/**
 增加limit参数，原因是如果不加限制，大点的gif图片解析会直接导致主线程卡死
 */
+ (UIImage *)sd_animatedGIFWithData:(NSData *)data limit:(NSInteger)limit_count;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
