//
//  UIImageView+ShowLargeImage.h
//  Maotachi
//
//  Created by lc on 2/24/13.
//  Copyright (c) 2013 lc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"

@interface UIImageView (ShowLargeImage)<UIScrollViewDelegate>

@property (nonatomic,strong) NSURL *largeImageURL;
@property (nonatomic,strong) UIImage *largeImage;
@property (nonatomic,assign) BOOL enableLargePreview;

@end
