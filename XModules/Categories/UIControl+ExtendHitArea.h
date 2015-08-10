//
//  UIControl+ExtendHitArea.h
//  SXClient
//
//  Created by stcui on 13-7-22.
//
//

#import <UIKit/UIKit.h>

@interface UIControl (ExtendHitArea)
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;
#ifdef DEBUG
@property(nonatomic,assign)BOOL debugExtendHitArea;
#endif
@end


