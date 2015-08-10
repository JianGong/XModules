//
//  UIImageView+ShowLargeImage.m
//  Maotachi
//
//  Created by lc on 2/24/13.
//  Copyright (c) 2013 lc. All rights reserved.
//

#import "UIImageView+ShowLargeImage.h"
#import "objc/runtime.h"
#import "ProgressView.h"
#import "UIApplication+hideStatusbar.h"
#import "UIImageView+PlayGIF.h"
#import "UIImage+MultiFormat.h"
#import "UIImageView+WebCache.h"
#import "UIView+Sizes.h"

#define kCoverViewTag           123456789
#define kCoverBgViewTag         123456779
#define KPhotoViewTag           1234567810
#define kImageViewTag           1234568911
#define kProgressViewTag        1000022121
//#define kScrollViewTag          1234568912
#define kAnimationDuration      0.3f
#define kImageViewWidth         300.0f
#define kBackViewColor          [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

@interface UIImageView()
@property (nonatomic,strong)UITapGestureRecognizer *tapGestureRecognizer;
@end

static char largeImageURLKey;
static char largeImageKey;

@implementation UIImageView (ShowLargeImage)
@dynamic enableLargePreview;

static char kTapGestureRecognizer;
- (UITapGestureRecognizer*)tapGestureRecognizer
{
    UITapGestureRecognizer *gest= objc_getAssociatedObject(self, &kTapGestureRecognizer);
    if (!gest) {
        gest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
        self.tapGestureRecognizer=gest;
    }
    return gest;
}

- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)gest
{
    objc_setAssociatedObject(self, &kTapGestureRecognizer, gest, OBJC_ASSOCIATION_RETAIN);
}

- (void)setEnableLargePreview:(BOOL)enableLargePreview
{
    if (enableLargePreview) {
        self.userInteractionEnabled = YES;
        [self removeGestureRecognizer:self.tapGestureRecognizer];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }else{
        self.userInteractionEnabled = NO;
        [self removeGestureRecognizer:self.tapGestureRecognizer];
    }
}

static UIImageView *stongSelf;

- (void)imageTap
{
    if(!self.image || !(self.largeImage || self.largeImageURL)){
        return;
    }
    
    stongSelf = self;
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectZero];
        bgview.backgroundColor = kBackViewColor;
    bgview.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    bgview.tag = kCoverBgViewTag;
    
    CGRect _frame = [[UIScreen mainScreen] bounds];
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        _frame.size = CGSizeMake(_frame.size.width, _frame.size.height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        _frame.size = CGSizeMake(_frame.size.height, _frame.size.width);
    }
    
    bgview.frame=_frame;
    bgview.alpha = 0;
    
    UIView *coverView = [[UIView alloc] initWithFrame:_frame];
    
    [[self myholdview] addSubview:coverView];
    [coverView addSubview:bgview];
    coverView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    coverView.tag = kCoverViewTag;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.tag = kImageViewTag;
    imageView.contentMode = self.contentMode;
    imageView.frame = [self convertRect:self.bounds toView:[self myholdview]];
    [coverView addSubview:imageView];
    imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    PhotoView *photoView = [[PhotoView alloc] initWithFrame:coverView.bounds];
    photoView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    photoView.tag = KPhotoViewTag;
    [coverView addSubview:photoView];
    [photoView setUserInteractionEnabled:NO];
    
    UITapGestureRecognizer *hiddenViewGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenViewAnimation)];
    [coverView addGestureRecognizer:hiddenViewGecognizer];
    
    [photoView.oneTap setEnabled:NO];
    [hiddenViewGecognizer requireGestureRecognizerToFail:photoView.doubleTap];
    
    [[UIApplication sharedApplication] _setStatusBarHidden:YES withAnimation:YES];
    
    if(self.largeImage){
        [UIView animateWithDuration:kAnimationDuration animations:^{
            bgview.alpha=1;
            imageView.image = self.largeImage;
            imageView.frame = coverView.bounds;
            imageView.contentMode  = UIViewContentModeScaleAspectFit;
        }completion:^(BOOL finished) {
            imageView.hidden = YES;
            if (self.largeImage.gifData) {
                photoView.imageView.gifData = self.largeImage.gifData;
                [photoView.imageView startGIF];
            }else{
                photoView.imageView.gifData=nil;
                photoView.image = self.largeImage;
            }
            photoView.userInteractionEnabled = YES;
        }];
    }else if(self.largeImageURL){

        imageView.frame = [self convertRect:self.bounds toView:[self myholdview]];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            bgview.alpha=1;
            imageView.center = CGPointMake(coverView.frame.size.width / 2.0, coverView.frame.size.height / 2.0);
        }];

        [self setProgressView];

        UIImage *originImage = self.image;
        [self sd_setImageWithURL:self.largeImageURL
                placeholderImage:originImage
                         options:0
                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            CGFloat progress = receivedSize * 1.0 / expectedSize;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[self progressView] setProgress:progress];
                            });
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [[self progressView] removeFromSuperview];
            if (!error&&image) {
                self.largeImage = image;
                if ([self.sd_imageURL isEqual:imageURL]) {
                    self.image = image;
                }
                imageView.image = image;
                [UIView animateWithDuration:kAnimationDuration animations:^{
                    imageView.frame = coverView.bounds;
                    imageView.contentMode  = UIViewContentModeScaleAspectFit;
                }completion:^(BOOL finished) {
                    imageView.hidden = YES;
                    if (image.gifData) {
                        photoView.imageView.gifData = image.gifData;
                        [photoView.imageView startGIF];
                    }else{
                        photoView.imageView.gifData=nil;
                        photoView.image = self.largeImage;
                    }
                    photoView.userInteractionEnabled = YES;
                }];
            }else{
                self.image=originImage;
            }
        }];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenViewNOAnimation) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark -
#pragma mark hidden

- (UIView *)myholdview
{
   return [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
}

- (void)hiddenView:(BOOL)animation
{
    PhotoView *photoView = (PhotoView*)[[self myholdview] viewWithTag:KPhotoViewTag];
    [photoView.imageView stopGIF];
    photoView.zoomScale = photoView.minimumZoomScale;
    photoView.hidden = YES;
    
    UIView *coverView = [(UIView *)[self myholdview] viewWithTag:kCoverViewTag];
    UIImageView *imageView = (UIImageView *)[[self myholdview] viewWithTag:kImageViewTag];
    imageView.hidden = NO;
    [[self progressView] removeFromSuperview];
    
    if (!animation) {
        [coverView removeFromSuperview];
        [[UIApplication sharedApplication] _setStatusBarHidden:NO withAnimation:NO];
    }else {
        UIView *bgView = [coverView viewWithTag:kCoverBgViewTag];
        [[UIApplication sharedApplication] _setStatusBarHidden:NO withAnimation:YES];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            bgView.alpha = 0 ;
            imageView.frame = [self convertRect:self.bounds toView:[self myholdview]];
        }completion:^(BOOL finished) {
            [coverView removeFromSuperview];
        }];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    stongSelf=nil;
}

- (void)hiddenViewAnimation {
    [self hiddenView:YES];
}

- (void)hiddenViewNOAnimation {
    [self hiddenView:NO];
}

#pragma mark -
#pragma mark progressView

- (void)setProgressView {
    ProgressView *progressView = [self progressView];
    if (!progressView) {
        UIView *coverView = [[self myholdview] viewWithTag:kCoverViewTag];
        progressView = [[ProgressView alloc] init];
        progressView.tag = kProgressViewTag;
        progressView.center = coverView.boundsCenter;
        [coverView addSubview:progressView];
    }
}

- (ProgressView *)progressView {//kProgressViewTag
    UIView *coverView = [[self myholdview] viewWithTag:kCoverViewTag];
    ProgressView *progressView = (ProgressView*)[coverView viewWithTag:kProgressViewTag];
    return progressView;
}

#pragma mark -
#pragma mark get or set

- (void)setLargeImageURL:(NSURL *)largeImageURL
{
    if (![self.largeImageURL isEqual:largeImageURL]) {
            objc_setAssociatedObject(self, &largeImageURLKey, largeImageURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.largeImage=nil;
    }
}

- (NSURL*)largeImageURL 
{
    return objc_getAssociatedObject(self, &largeImageURLKey);;
}

- (void)setLargeImage:(UIImage *)largeImage
{ 
    objc_setAssociatedObject(self, &largeImageKey, largeImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage*)largeImage
{
    return objc_getAssociatedObject(self, &largeImageKey);;
}
@end
