//
//  XVerticalButton.m
//  Parking
//
//  Created by iBcker on 15/12/29.
//  Copyright © 2015年 ibcker. All rights reserved.
//

#import "XVerticalButton.h"

@implementation XVerticalButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.centerX = self.width/2;
    self.imageView.left = self.imageView.left + self.imageEdgeInsets.left-self.imageEdgeInsets.right;
    
    self.imageView.centerY = self.height/2-self.titleLabel.height/2;

    self.titleLabel.frame = CGRectMake(self.titleEdgeInsets.left, 0, self.width-self.titleEdgeInsets.left-self.titleEdgeInsets.right, self.titleLabel.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.top = self.imageView.bottom+self.titleEdgeInsets.top-self.titleEdgeInsets.bottom;

    self.imageView.top = self.imageView.top + self.imageEdgeInsets.top-self.imageEdgeInsets.bottom;
    
}

@end
