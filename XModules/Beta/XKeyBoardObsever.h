//
//  XKeyBoardObsever.h
//  rongxue
//
//  Created by iBcker on 15/8/2.
//  Copyright © 2015年 ibcker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKeyBoardObsever : NSObject
@property (nonatomic,strong)void (^keyboardWillShow)(CGRect keyboardRect);
@property (nonatomic,strong)void (^keyboardWillHide)();

@end
