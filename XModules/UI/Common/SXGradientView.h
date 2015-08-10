//
//  SXGradientView.h
//  PPeng
//
//  Created by iBcker on 15/7/7.
//  Copyright © 2015年 实现. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXGradientView : UIView
@property (nonatomic,copy)NSArray *colors;
@property (nonatomic,copy)NSArray/*<NSNumber *>*/ *locations;

@property(nonatomic,assign) CGPoint startPoint;
@property(nonatomic,assign) CGPoint endPoint;

@end
