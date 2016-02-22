//
//  SXTableViewCell.m
//  SXClient
//
//  Created by iBcker on 14-9-14.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXTableViewCell.h"
#import "UIColor+HexString.h"
#import "UIView+Sizes.h"
#import "CGUtil.h"

@interface SXTableViewCell()
@property (nonatomic,strong)CALayer *bottomLine;
@property (nonatomic,strong)UIColor *originBackgroundColor;
@end

const CGFloat SXDefaultHeight = 44;
@implementation SXTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectBackgroundColor=[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
#warning ios 5下设置背景色问题，有待查找原因
        self.backgroundColor=[UIColor whiteColor];
        [self onInitialize];
        _bottomLinePadding=0;
        _bottomLineWeight=0.5;
    }
    return self;
}

- (void)onInitialize
{}

- (void)setBottomLinePadding:(CGFloat)bottomLinePadding
{
    _bottomLinePadding=bottomLinePadding;
    self.bottomLineInset=UIEdgeInsetsMake(0, bottomLinePadding, 0, bottomLinePadding);
    [self setShowBottomLine:_showBottomLine];
}

- (void)dealloc
{
    self.delegate=nil;
}

+ (CGFloat)heightForContent:(id)content limitWidth:(CGFloat)width ext:(id)ext
{
    return SXDefaultHeight;
}

- (void)setSelectEnable:(BOOL)selectEable
{
    _selectEnable=selectEable;
    self.selectedBackgroundView.hidden=!selectEable;
}

- (void)setContent:(id)content ext:(id)ext
{
    self.content=content;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setShowBottomLine:_showBottomLine];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (!self.selectedBackgroundView&&_selectBackgroundColor) {
        if (highlighted) {
            [super setBackgroundColor:_selectBackgroundColor];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                [super setBackgroundColor:self.originBackgroundColor];
            }];
        }
    }
}

- (void)setSelectBackgroundColor:(UIColor *)selectBackgroundColor
{
    if (selectBackgroundColor) {
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = selectBackgroundColor;
        [self setSelectedBackgroundView:bgColorView];
    }else{
        [self setSelectedBackgroundView:nil];
    }
}

- (CALayer *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine  = [CALayer layer];
        [self.layer addSublayer:_bottomLine];
    }
    return _bottomLine;
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    _showBottomLine=showBottomLine;
    self.bottomLine.hidden=!showBottomLine;
    if (showBottomLine) {
        UIEdgeInsets inset = self.bottomLineInset;
        self.bottomLine.frame=CGRectMakeByXBootom(inset.left, self.height-inset.bottom, self.width-inset.right-inset.left, _bottomLineWeight);
        self.bottomLine.backgroundColor=_bottomLineColor.CGColor?:[UIColor colorWithHex:0xDDDDDD].CGColor;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.content=nil;
}

@end
