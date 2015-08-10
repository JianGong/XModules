//
//  UIView+sideBorder.h
//  rongxue
//
//  Created by iBcker on 15/7/10.
//  Copyright © 2015年 ibcker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (sideBorder)
@property (nonatomic,strong)UIView *_sideLeftBorder;
@property (nonatomic,strong)UIView *_sideTopBorder;
@property (nonatomic,strong)UIView *_sideBottomBorder;
@property (nonatomic,strong)UIView *_sideRightBorder;

-(void)setLeftBorder:(BOOL)show;
-(void)setLeftBorder:(BOOL)show color:(UIColor *)color;//inset{0,0,0,0} wigth:1
-(void)setLeftBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight;
-(void)setLeftBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight;

-(void)setTopBorder:(BOOL)show;
-(void)setTopBorder:(BOOL)show color:(UIColor *)color;//inset{0,0,0,0} wigth:1
-(void)setTopBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight;
-(void)setTopBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight;

-(void)setBottomBorder:(BOOL)show;
-(void)setBottomBorder:(BOOL)show color:(UIColor *)color;//inset{0,0,0,0} wigth:1
-(void)setBottomBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight;
-(void)setBottomBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight;

-(void)setRightBorder:(BOOL)show;
-(void)setRightBorder:(BOOL)show color:(UIColor *)color;//inset{0,0,0,0} wigth:1
-(void)setRightBorder:(BOOL)show color:(UIColor *)color weight:(CGFloat)weight;
-(void)setRightBorder:(BOOL)show color:(UIColor *)color inset:(UIEdgeInsets)inset weight:(CGFloat)weight;
@end
