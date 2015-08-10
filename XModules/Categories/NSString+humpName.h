//
//  NSString+humpName.h
//  SXClient
//
//  Created by iBcker on 14-10-10.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (humpName)

- (NSString *)lowercaseHumpNameString;
- (BOOL)hasLowerCharPrefix;
- (BOOL)hasUpperCharPrefix;
@end
