//
//  SXButton.h
//  SXClient
//
//  Created by iBcker on 15/3/3.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXButton : UIButton
@property(nonatomic,strong)void (^onTouchUpInside)(SXButton *bton);
@end
