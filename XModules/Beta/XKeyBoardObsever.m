//
//  XKeyBoardObsever.m
//  rongxue
//
//  Created by iBcker on 15/8/2.
//  Copyright © 2015年 ibcker. All rights reserved.
//

#import "XKeyBoardObsever.h"

@implementation XKeyBoardObsever

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)keyboardWillShow:(NSNotification *)notification {
    

    NSDictionary *userInfo = [notification userInfo];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];

    if (self.keyboardWillShow) {
        [UIView beginAnimations:nil context:NULL];
        NSTimeInterval animationDuration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve type=[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:type];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.keyboardWillShow(keyboardRect);
        [UIView commitAnimations];
    }
}

//- (void)keyboardWillChangeRect:(NSNotification *)notification {}
//- (void)keyboardDidShow:(NSNotification *)notification {}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    [UIView beginAnimations:nil context:NULL];
    NSTimeInterval animationDuration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve type=[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:type];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (self.keyboardWillHide) {
        self.keyboardWillHide();
    }
    [UIView commitAnimations];
    
}


@end
