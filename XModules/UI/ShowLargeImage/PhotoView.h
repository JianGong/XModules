//
//  PhotoView.h
//  PhotoTest
//
//  Created by lc on 4/1/13.
//  Copyright (c) 2013 lc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,readonly,strong) UIImageView *imageView;
@property (nonatomic,assign)          UIImage *image;

@property (nonatomic,assign)          float tapZoomStep;

@property (nonatomic,readonly,strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic,readonly,strong) UITapGestureRecognizer *oneTap;

- (id)initWithImage:(UIImage*)image;
- (void)setImageName:(NSString *)imageName;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)resetDefaultScale;

@end



@interface UIScrollView (Zoom)
- (BOOL)isZoomed;
- (CGRect)zoomRectAtCenter:(CGPoint)center scale:(float)scale;
- (void)zoomAtPoint:(CGPoint)point animated:(BOOL)animated;
- (void)zoomAtPoint:(CGPoint)point scale:(float)scale animated:(BOOL)animated;

@end
