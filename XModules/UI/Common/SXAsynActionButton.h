//
//  SXAsynActionButton.h
//  SXClient
//
//  Created by iBcker on 14-10-5.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXAsynActionButton : UIButton
@property (nonatomic,assign,getter=isLoading)BOOL loading;
@end



@interface SXRoundedRectButton :SXAsynActionButton

@end