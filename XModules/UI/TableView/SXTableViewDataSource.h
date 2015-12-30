//
//  SXTableViewAdapter.h
//  SXClient
//
//  Created by iBcker on 14-9-24.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTableViewHelper.h"

@class SXTableView,SXTableViewCell;

@protocol SXTableViewDataSourceDelegate <NSObject>

@optional
- (void)sxtableView:(SXTableView *)tableView cell:(SXTableViewCell *)cell onResponse:(SEL)sel withObjs:(NSArray *)objs;

@end

@interface SXTableViewDataSource : NSObject<UITableViewDataSource>
@property (nonatomic,readonly,weak)SXTableView *tableView;
@property (nonatomic,strong)NSArray *objs;

@property (nonatomic,weak)id<SXTableViewDataSourceDelegate> delegate;

///init the data tableview datasource
- (id)initWithTableView:(UITableView *)tableView;

- (SXTableViewCell *)sxtableView:(SXTableView *)tableView cellForObj:(SXCellObj *)obj;

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath;
- (id)extForCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(SXTableView *)tableView onCreateCell:(SXTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(SXTableView *)tableView onConfigCell:(SXTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
