//
//  SXTableView.h
//  SXClient
//
//  Created by iBcker on 14-9-15.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTableViewCell.h"
#import "SXTableViewHelper.h"
#import "SXTableViewDataSource.h"

@interface UITableView(makeCell)
- (id)dequeueReusableCell:(Class)clazz withIdentifier:(NSString *)identifier;
- (id)dequeueReusableCellWithClass:(Class)identifierClazz;
@end

@interface SXTableView : UITableView
@end
