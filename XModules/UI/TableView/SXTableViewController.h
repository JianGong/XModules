//
//  SXMainViewController.h
//  SXClient
//
//  Created by iBcker on 14-9-30.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXViewController.h"
#import "SXTableView.h"
#import "SXTableViewDataSource.h"
#import "SRRefreshView.h"
#import "WLoadMore.h"
#import "SXViewModel.h"

@interface SXTableViewController : SXViewController<UITableViewDelegate,SRRefreshDelegate,WLoadMoreDelegate,SXTableViewDataSourceDelegate>
@property (nonatomic,strong)IBOutlet SXTableView *tableView;
@property (nonatomic,strong)SRRefreshView *refreshView;
@property (nonatomic,strong)WLoadMore *loadMoreControl;
@property (nonatomic,strong)SXTableViewDataSource *dataSource;
@property (nonatomic,strong)SXViewModel *viewModel;

@property (nonatomic,assign)BOOL needPull2Refresh;
@property (nonatomic,assign)BOOL needLoadMore;

- (Class)dataSourceClass;
- (Class)viewModelClass;

- (UITableViewStyle)tableViewStyle;//default UITableViewStylePlain
- (CGFloat)autoInsetsBottom;
- (CGFloat)autoInsetsTop;

- (void)loadData;
- (void)reloadData;
- (void)reloadTableView;
- (NSArray *)buildCellObjes:(NSArray *)res;

- (BOOL)needRefresh;
- (BOOL)canLoadMore;
- (void)updateCacheTime;

@end
