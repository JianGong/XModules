//
//  SXDelayButton.h
//  
//
//  Created by iBcker on 15/6/14.
//
//

#import "SXAsynActionButton.h"

typedef void (^_delayButtonCompleteBlock)(BOOL finished);

typedef NSString * (^_delayButtonTitleBlock)(NSInteger totle,NSInteger pass);

@interface SXDelayButton : SXAsynActionButton
@property (nonatomic,assign,readonly,getter=isDelaying)BOOL delaying;
- (void)setDelay:(NSInteger)time title:(_delayButtonTitleBlock)title complete:(_delayButtonCompleteBlock)complete;
- (void)stopSetDelayTitle;
@end
