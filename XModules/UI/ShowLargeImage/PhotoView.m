//
//  PhotoView.m
//  PhotoTest
//
//  Created by lc on 4/1/13.
//  Copyright (c) 2013 lc. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+PlayGIF.h"

@implementation PhotoView

- (id)initWithImage:(UIImage*)image
{
    if(self == [self initWithFrame:CGRectZero]){
        self.image = image;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tapZoomStep  = 1.0;

        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        _imageView = imageView;
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
        
        oneTap.numberOfTapsRequired = 1;
        doubleTap.numberOfTapsRequired = 2;
        [oneTap requireGestureRecognizerToFail:doubleTap];
        
        [self addGestureRecognizer:oneTap];
        [self addGestureRecognizer:doubleTap];
        
        _doubleTap = doubleTap;
        _oneTap = oneTap;
    
        [self.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if(!CGRectEqualToRect(self.frame, frame)){
        [super setFrame:frame];
        [self setMaxMinZoomScalesForCurrentBounds];
    }
}

- (void)dealloc
{
    [self.imageView removeObserver:self forKeyPath:@"image"];
}

#pragma mark -
#pragma mark Image method

- (void)setImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image];
}


- (void)setImage:(UIImage *)newImage
{
    self.imageView.image = newImage;
}

- (UIImage*)image
{
    return self.imageView.image;
}

#pragma mark -
#pragma mark Scale Methods

- (void)setMaxMinZoomScalesForCurrentBounds
{
    [self setScaleDefault];
    if(!self.imageView.image || CGSizeEqualToSize(self.bounds.size, CGSizeZero)) return;
    
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _imageView.image.size;
    
    // calculate min/max zoomscale
    CGFloat xScale = boundsSize.width / imageSize.width;
    CGFloat yScale = boundsSize.height  / imageSize.height;
    CGFloat minScale = MIN(xScale, yScale);
    
    // If image is smaller than the screen then ensure we show it at
	// min scale of 1
    //minScale = minScale > 1.0 ? 1.0 : minScale;
    
    
    CGFloat maxScale = 4.0 / [[UIScreen mainScreen] scale];
    minScale = MIN(minScale, maxScale);
    
    self.minimumZoomScale = minScale;
    self.maximumZoomScale = maxScale;
    self.zoomScale = minScale;
    
    if(minScale == 1.0){
        [self adjustImageViewOriginForCurrentScale];
    }
}

- (void)setScaleDefault
{
    self.minimumZoomScale = 1;
    self.maximumZoomScale = 1;
    self.zoomScale = 1;
}

- (void)adjustImageViewOriginForCurrentScale
{
    CGRect imageViewfrmae = self.imageView.frame;
    CGRect bounds = self.bounds;
    
    CGFloat diffX = CGRectGetWidth(bounds) - CGRectGetWidth(imageViewfrmae);
    CGFloat diffY = CGRectGetHeight(bounds) - CGRectGetHeight(imageViewfrmae);
    
    imageViewfrmae.origin.x = diffX > 0 ? diffX / 2.0 : 0;
    imageViewfrmae.origin.y = diffY > 0 ? diffY / 2.0 : 0;
    self.imageView.frame = imageViewfrmae;
}

- (void)resetDefaultScale
{
    self.zoomScale = self.minimumZoomScale;
}

- (CGRect)imageViewFrame
{
    UIImage *image = self.imageView.image;
    CGRect imageViewFrame = CGRectZero;
    if(image){
        imageViewFrame.size = image.size;
    }
    return imageViewFrame;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{   
    [self adjustImageViewOriginForCurrentScale];
}

- (void)doubleTap:(UITapGestureRecognizer*)sender
{
    if (self.imageView.isGIFPlaying) {
        return;
    }
    if([self isZoomed]){
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }else{
        CGPoint point = [sender locationInView:self.imageView];
        [self zoomAtPoint:point scale:self.tapZoomStep * self.maximumZoomScale  animated:YES];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == self.imageView && [keyPath isEqualToString:@"image"]){
        [self setScaleDefault];
        [self.imageView setFrame:[self imageViewFrame]];
        [self setMaxMinZoomScalesForCurrentBounds];
    }
}

@end


@implementation UIScrollView (Zoom)

- (BOOL)isZoomed
{
    return self.zoomScale != self.minimumZoomScale;
}

- (CGRect)zoomRectAtCenter:(CGPoint)center scale:(float)scale
{
    CGRect zoomRect;
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width  = [self frame].size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)zoomAtPoint:(CGPoint)point animated:(BOOL)animated
{
    CGRect zoomRect = [self zoomRectAtCenter:point scale:self.maximumZoomScale];
    [self zoomToRect:zoomRect animated:animated];
}

- (void)zoomAtPoint:(CGPoint)point scale:(float)scale animated:(BOOL)animated
{
    CGRect zoomRect = [self zoomRectAtCenter:point scale:scale];
    [self zoomToRect:zoomRect animated:animated];
}

@end
