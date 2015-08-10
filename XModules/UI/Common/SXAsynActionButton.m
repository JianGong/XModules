//
//  SXAsynActionButton.m
//  SXClient
//
//  Created by iBcker on 14-10-5.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXAsynActionButton.h"
#import "UIImage+factory.h"
#import "SXImageCache.h"
#import "UIColor+HexString.h"

@interface SXAsynActionButton()
@property(nonatomic,strong)UIActivityIndicatorView *indicator;
@end

@implementation SXAsynActionButton

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
    }
    return self;
}

- (UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        _indicator=[[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        _indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
        _indicator.hidesWhenStopped=YES;
        _indicator.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:_indicator];
    }
    return _indicator;
}

- (void)setLoading:(BOOL)loading
{
    _loading=loading;
    if (loading) {
        [self.indicator startAnimating];
        self.indicator.alpha=0;
    }else{
        [_indicator stopAnimating];
    }
    [UIView animateWithDuration:0.25 animations:^{
        _indicator.alpha=loading?1:0;
        self.titleLabel.alpha=loading?0:1;
    }];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setLoading:NO];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setLoading:NO];
}

@end

@implementation SXRoundedRectButton

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self setBackgroundImage:SXIMAGEHEX(0x20C8AF) forState:UIControlStateNormal];
        [self setBackgroundImage:SXIMAGEHEX(0xEEEEEE) forState:UIControlStateSelected];
        [self setBackgroundImage:SXIMAGEHEX(0xEEEEEE) forState:UIControlStateSelected|UIControlStateHighlighted];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateSelected|UIControlStateHighlighted];
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:13];
        [self.layer setCornerRadius:2];
        self.layer.borderColor=[UIColor colorWithWhite:0 alpha:0.14].CGColor;
        self.layer.borderWidth=0.5;
        self.layer.rasterizationScale=[[UIScreen mainScreen] scale];
        self.layer.shouldRasterize=YES;
        self.clipsToBounds=YES;
    }
    return self;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    BOOL isSelectd= self.isEnabled;
//    [super touchesBegan:touches withEvent:event];
//    [self setSelected:isSelectd];
//}

@end
