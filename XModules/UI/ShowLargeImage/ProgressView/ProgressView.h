//
//  ProgressView.h
//  Test
//
//  Created by lc on 3/15/13.
//  Copyright (c) 2013 lc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property (nonatomic,strong) UIColor   *linkBackgroundColor;
@property (nonatomic,strong) UIColor   *linkColor;
@property (nonatomic,assign) CGFloat    linkWidth;
@property (nonatomic,assign) CGLineCap  lineCapStyle;
@property (nonatomic,assign) CGFloat    progressOffset; // -1 ~ 1 default is -0.025

@property (nonatomic,assign) CGFloat    progress; // default start form 0.05
@property (nonatomic,assign) BOOL       disMissWhenCompleted;

@end
